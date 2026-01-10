set -e

FLAKE_FILE="flake.nix"
nix flake update

# 运行 nix build，捕获报错中的正确 hash
BUILD_OUTPUT=$(nix build . 2>&1 || true)
HASH=$(echo "$BUILD_OUTPUT" | grep -o 'got:.*' | head -n1 | awk '{print $2}')

if [[ -z "$HASH" ]]; then
  exit 0
fi

# 自动替换 flake.nix 里的 cargoHash
sed -i "s/cargoHash = \".*\";/cargoHash = \"$HASH\";/g" "$FLAKE_FILE"

echo "已自动更新 cargoHash 为: $HASH"
nix build .