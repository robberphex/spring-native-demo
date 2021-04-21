#!/bin/sh

java -javaagent:/app/pinpoint-agent-2.2.2/pinpoint-bootstrap.jar \
  -Dpinpoint.agentId=test-agent \
  -Dpinpoint.applicationName=TESTAPP \
  -jar /app/sc-A-0.0.1-SNAPSHOT.jar
