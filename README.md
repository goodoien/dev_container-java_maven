# A Docker Dev container for Java/Maven development

## Basic container creation 

This is done with the `compose-dev.yaml` file. This file is used to create a container that can be used for development.  It is not intended to be used for production.  The container is created with the docker desktop dev container section. 

## settings.xml

The `settings.xml` is used to configure the maven settings. The file is copied into the container at `/root/.m2/settings.xml`. The file is configured to use the private GitHub repository packages by adding your Personal Access Token. You will need to create this file and add your token using the following template:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <activeProfiles>
    <activeProfile>github</activeProfile>
  </activeProfiles>

  <profiles>
    <profile>
      <id>github</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>https://repo1.maven.org/maven2</url>
        </repository>
        <repository>
          <id>github</id>
          <url>{Private ORG Github Packages url. End with /*}</url>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>
          
  <servers>
      <server>
          <id>github</id>
          <username>{PAL Token Name}</username>
          <password>{PAL Token}</password>
      </server>
  </servers>

</settings>

```