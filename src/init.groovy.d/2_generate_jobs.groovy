def sout = new StringBuffer(), serr = new StringBuffer()

def proc ='/var/jenkins_home/init.groovy.d/2_jobs.sh'.execute()

proc.consumeProcessOutput(sout, serr)
proc.waitForOrKill(1000)
println sout