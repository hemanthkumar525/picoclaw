#!/bin/sh

echo "OPENROUTER_API_KEY length: ${#OPENROUTER_API_KEY}"

mkdir -p /root/.picoclaw

cat <<EOF > /root/.picoclaw/config.json
{
  "agents": {
    "defaults": {
      "model": "anthropic/claude-3-haiku"
    }
  },
  "providers": {
    "openrouter": {
      "api_key": "${OPENROUTER_API_KEY}",
      "api_base": "https://openrouter.ai/api/v1"
    }
  }
}
EOF

export PORT=${PORT:-18790}

exec picoclaw gateway --port $PORT
