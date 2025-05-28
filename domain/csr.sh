#!/bin/bash

BASE_DIR="/Users/I347305/certs/ias.authz.id"
# === Configuration ===
DOMAIN_CERT="$BASE_DIR/ias.authz.id.cer"
CA_CERT="$BASE_DIR/ca.cer"
FULLCHAIN_OUT="$BASE_DIR/fullchain-ias.pem"

# === Check files exist ===
if [[ ! -f "$DOMAIN_CERT" ]]; then
  echo "❌ Error: Domain certificate '$DOMAIN_CERT' not found."
  exit 1
fi

if [[ ! -f "$CA_CERT" ]]; then
  echo "❌ Error: Intermediate CA certificate '$CA_CERT' not found."
  exit 1
fi

# === Combine the fullchain in correct order: leaf -> intermediate ===
echo "🔧 Generating fullchain PEM..."
cat "$DOMAIN_CERT" "$CA_CERT" > "$FULLCHAIN_OUT"

# === Validate the output ===
echo "🔍 Validating certificate chain..."
openssl x509 -in "$DOMAIN_CERT" -noout -subject -issuer
openssl x509 -in "$CA_CERT" -noout -subject -issuer

echo
echo "✅ Combined certificate written to: $FULLCHAIN_OUT"

# === Show Subject and SAN to verify it's correct ===
echo "📋 Final fullchain info:"
openssl x509 -in "$FULLCHAIN_OUT" -text -noout | grep -E 'Subject:|Issuer:|DNS:|Signature Algorithm'

echo
echo "📝 Next Step:"
echo "  → Open SAP IAS Admin Console"
echo "  → Go to: Tenant Settings > Custom Domain"
echo "  → Paste the contents of $FULLCHAIN_OUT into the Certificate field"
echo "  → Click Save, and wait for activation (~15 mins)"
