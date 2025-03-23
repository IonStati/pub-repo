#!/bin/bash

echo -n "1. Enter input and hit Enter... "
read -s user_input
echo

algorithms=(
    "sha1"
    "sha224"
    "sha256"
    "sha3-224"
    "sha3-256"
    "sha3-384"
    "sha3-512"
    "sha384"
    "sha512"
    "sha512-224"
    "sha512-256"
    "shake128"
    "shake256"
)

echo
echo "  Hash algorithms to choose from: "
for i in "${!algorithms[@]}"; do
	printf "   (%2d) %s\n" $((i + 1)) "${algorithms[$i]}"
done

echo
echo -n "2. Enter corresponding number and hit Enter... "
read -s algorithm_index
echo

selected_algorithm="${algorithms[$((algorithm_index - 1))]}"
hash=$(echo -n "$user_input" | openssl dgst -$selected_algorithm | awk '{print $2}')
hash_base64=$(echo -n "$hash" | openssl base64 -A)

echo
echo "Hash: $hash"
echo "Base64: $hash_base64"
