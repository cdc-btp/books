import { executeHttpRequest } from '@sap-cloud-sdk/http-client'
import https  from 'https';

function find(identityServices, name) {
  const service = identityServices.find(service => service.name === name);
  if (!service) {
    throw new Error(`Service with name ${name} not found`);
  }
  return service.credentials;
}

async function main() {
  // 1. Read IAS credentials from VCAP_SERVICES
  if (!process.env.VCAP_SERVICES) {
    throw new Error("VCAP_SERVICES missing");
  }
  const vcap = JSON.parse(process.env.VCAP_SERVICES);
  const identityServices= vcap["identity"];
  const name="idp"  ;
  if (!identityServices || !Array.isArray(identityServices) || identityServices.length === 0) {
    throw new Error(`No identity service found in VCAP_SERVICES with name: ${name}`);
  }
  const credentials = find(identityServices, name);

  // 2. Create HTTPS agent with X.509 cert/key
  const agent = new https.Agent({
    cert: credentials.certificate,
    key: credentials.key,

    // Optionally: ca: ias.ca, rejectUnauthorized: true
  });

  // 3. Prepare your IAS API call (example: create IDP)
  const idpConfig = {
    name: "cdc-idp",
    displayName: "SAP CDC Identity Provider (Test)",
    companyId: "global",
    type: "openIdConnect",
    forwardAllSsoRequests: true,
    identityFederation: {
      useLocalUserStore: false,
      allowLocalUsersOnly: false,
      applyLocalIdPAuthnChecks: false
    },
    automaticRedirect: true,
    loginHintConfiguration: {
      loginHintType: "userInput",
      sendMethod: "urlParam"
    },
    saml2Configuration: {
      digestAlgorithm: "sha256",
      includeScoping: true,
      defaultNameIdFormat: "default",
      allowCreate: "none",
      assertionAttributes: [
        {name: "groups", value: "${groups}"},
        {name: "global_user_id", value: "${id}"},
        {name: "user_uuid", value: "${sub}"},
        {name: "mail", value: "${email}"}
      ]
    },
    oidcConfiguration: {
      subjectNameIdentifier: "email",
      discoveryUrl: "https://fidm.eu1.gigya.com/oidc/op/v1.0/4_aqGBGirVPg5zOIVhZhnNpQ/.well-known/openid-configuration",
      scopes: ["openid", "profile", "groups", "email"],
      tokenEndpointAuthMethod: "privateKeyJwt",
      clientId: "IfcuTnR1UVv2rVrBTj5cMk8i",
      isClientSecretConfigured: false,
      pkceEnabled: true,
      additionalConfig: {
        enforceNonce: false,
        enforceIssuerCheck: false,
        omitIDTokenHintForLogout: false
      }
    }
  };
  const baseUrl = `${credentials.url}`;


  //check if identity provider already exists
  // if it exists, calculate patch request
  //if it does not exist, post the new identity provider

  //find identity provider with the same discoveryUrl
  
  const identityProviders = await executeHttpRequest(
      {url: `${baseUrl}/IdentityProviders/v1/`},
      {
        method: 'GET',
        httpsAgent: agent
      }
      
  );
  const existingIdp = identityProviders.data.find(idp =>
      idp.oidcConfiguration && idp.oidcConfiguration.discoveryUrl === idpConfig.oidcConfiguration.discoveryUrl
  );
  console.log('Existing Identity Providers:', identityProviders.data);
  if (existingIdp) {
    //patch existing identity provider
    const path = `/IdentityProviders/v1/${existingIdp.id}`;
    try {
      const response = await executeHttpRequest(
          {url: `${baseUrl}/${path}`},
          {
            method: 'PATCH',
            data: {
              operations: [
                {
                  op: 'replace',
                  path: '/oidcConfiguration',
                  value: idpConfig.oidcConfiguration
                }
                ]
            },
            httpsAgent: agent,
            headers: {
              'Content-Type': 'application/json'
            }
          }
      );
      console.log('IAS IDP config updated successfully:', response.data);
    } catch (err) {
      console.error('Failed to update IAS IDP config:', err.response ? err.response.data : err);
      process.exit(0);
    }
  } else {
    //post new identity provider 

    try {
      const response = await executeHttpRequest(
          {url: `${baseUrl}/IdentityProviders/v1/`},
          {
            method: 'POST',
            url: path,
            data: idpConfig,
            httpsAgent: agent,
            headers: {
              'Content-Type': 'application/json'
            }
          }
      );
      console.log('IAS IDP config applied successfully:', response.data);
    } catch (err) {
      console.error('Failed to apply IAS IDP config:', err.response ? err.response.data : err);
      process.exit(0);
    }
  }
}

main().catch(err => {
    console.error('Error in main function:', err.response ? err.response.data : err);
    process.exit(0);
 });