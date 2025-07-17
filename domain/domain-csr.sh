#!/bin/bash

# === CONFIGURATION ===

# Your custom domain (must match what you entered in SAP IAS)
DOMAIN="ias.authz.id"

# Path to your downloaded CSR from SAP IAS
CSR_PATH="./domain.csr"
export PORKBUN_API_KEY="pk1_81ec960dc33ec0a8374d48c727bae45883833b588ea2b89e13899eab58188101"


# === INSTALL ACME.SH IF NEEDED ===
if ! command -v acme.sh >/dev/null 2>&1; then
  echo "Installing acme.sh..."
  curl https://get.acme.sh | sh
  source ~/.acme.sh/acme.sh.env
else
  echo "acme.sh found, using existing installation."
fi

# Ensure acme.sh env is sourced
if [ -f ~/.acme.sh/acme.sh.env ]; then
  source ~/.acme.sh/acme.sh.env
fi

# Set Let's Encrypt as default CA
acme.sh --set-default-ca --server letsencrypt

# Register an account if not already done
acme.sh --register-account -m "dina.vintr@gmail.com"

# === SIGN THE CSR ===
echo "Signing CSR from: $CSR_PATH for domain: $DOMAIN"

acme.sh --signcsr --csr "$CSR_PATH" -d "$DOMAIN" --dns dns_porkbun

# === OUTPUT FILES ===
CERT_DIR=~/.acme.sh/"$DOMAIN"
SIGNED_CERT="$CERT_DIR/$DOMAIN.cer"
FULLCHAIN_CERT="$CERT_DIR/fullchain.cer"

echo
echo "✅ Signing complete."
echo "Signed certificate:        $SIGNED_CERT"
echo "Full chain certificate:    $FULLCHAIN_CERT"

echo
echo "👉 To upload to SAP IAS:"
echo "1. Open the fullchain certificate in a text editor:"
echo "     cat \"$FULLCHAIN_CERT\""
echo "2. Copy-paste the content into SAP IAS → Custom Domain → Certificate field."
echo
