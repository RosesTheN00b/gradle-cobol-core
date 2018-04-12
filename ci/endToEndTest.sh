set -e

echo ">>>>>>> creating test-repository"
mkdir endToEndTest
cd endToEndTest
git clone https://github.com/RosesTheN00b/gradle-cobol-plugin-example
echo "<<<<<<<"

echo ">>>>>>> install test-repo"
sh gradle-cobol-plugin-example/ci/install_requirements.sh
echo "<<<<<<< install rest repo"

echo ">>>>>>> create local repo"
cd ..
gradle publish
mv ../repo endToEndTest/repo
echo "<<<<<<<"

echo ">>>>>>> prepare test-repository"
rm -v endToEndTest/gradle-cobol-plugin-example/settings.gradle
cp endToEndTest/gradle-cobol-plugin-example/ci/local_repo_test_settings.gradle endToEndTest/gradle-cobol-plugin-example/settings.gradle
rm -v endToEndTest/gradle-cobol-plugin-example/build.gradle
cp ci/build.gradle.replacement endToEndTest/gradle-cobol-plugin-example/build.gradle
echo "<<<<<<<"

echo ">>>>>>> exec test"
cd endToEndTest/gradle-cobol-plugin-example
gradle cobolCheck
echo "<<<<<<<"
