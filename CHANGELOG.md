# tftools Release History

## 0.1.0 [2020-07-11]

### Initial release

- Added the cmdlet *Install-Terraform*
    - Creates a working directory (.tftools) under your home directory
    - Verifies the version one is trying to install
    - Checkes if the version is already installed
    - Downloads the release from HashiCorp and unzip it to the working directory, cataloged by version number