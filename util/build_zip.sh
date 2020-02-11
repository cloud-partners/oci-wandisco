#!/usr/bin/env bash


# Will build zip file off remote master to pass to ORM
# TESTING against local files!!!!

echo "Cleanup tmp_package and package.zip"
rm -rf ./tmp_package
rm package.zip

echo "Creating tmp dir...."
mkdir ./tmp_package

#cd ./tmp_package
#git clone git clone https://github.com/oracle/oci-quickstart-h2o.git
#rm -rf ./images
#rm -rf README.md

echo "Copying .tf files to tmp dir...."
cp -v ../*.tf ./tmp_package
cp -v ../schema.yml ./tmp_package
echo "Copying script directory to tmp dir...."
cp -rv ../scripts ./tmp_package

echo "Removing provider.tf...."
rm ./tmp_package/provider.tf

#echo "Adding schema.yaml..."
#cp schema.yaml ./tmp_package

# The horror...
echo  "Removing variables unallowed by ORM..."
sed -i '' "s/variable \"user_ocid\" {}//g" ./tmp_package/variables.tf
sed -i '' "s/variable \"fingerprint\" {}//g" ./tmp_package/variables.tf
sed -i '' "s/variable \"private_key_path\" {}//g" ./tmp_package/variables.tf

# Add latest git log entry
git log -n 1 > ./tmp_package/git.log

echo "Creating zip...."
cd tmp_package
zip -r package.zip *
cd ..
mv tmp_package/package.zip ./

echo "Deleting tmp dir...."
rm -rf ./tmp_package
