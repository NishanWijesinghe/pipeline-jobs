import hudson.model.*
import jenkins.model.*
import jenkins.security.*
import jenkins.security.apitoken.*

// script parameters
def userName = 'admin'
def tokenName = 'kb-token'

def user = User.get(userName, false)
def apiTokenProperty = user.getProperty(ApiTokenProperty.class)
def result = apiTokenProperty.tokenStore.generateNewToken(tokenName)
user.save()

//ANTI BEST PRACTICE: write this to secure vault, e.g., AWS SSM secureString
//This is proof of concept for automation Jenkins where Dev/Sec/Git-Ops engineer
//has zero UI/manual touches. Write file any folder owned by jenkins user
File file = new File("/usr/local/bin/jenkins-job-builder/api-info")
file << "token="
file << result.plainValue

return result.plainValue