echo "Linting..."
tflint --recursive -f compact

echo "Formatting..."
terraform fmt -recursive

echo "Running checkov"
checkov -d ./ --skip-check=CKV2_GCP_18,CKV2_GHA_1,CKV_TF_1 --quiet
