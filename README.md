# Docker container - Android SDK + Gradle
Base image of the docker for using android app build processes

## About

This project contains the source code of the docker image used to compile an android application using gradle

The docker image contains the following components:

<br />

## Commands

<br />

### Start
```
  npm run start
```
or  
```
  ./start.sh
```  
or  
```
  docker-compose -f docker-compose.yml up -d --force-recreate --build
``` 

<br />


### Restart
```
  npm run restart
```  
or
```
  ./restart.sh
``` 
or  
```
  docker-compose -f docker-compose.yml down && docker-compose -f docker-compose.yml up -d --force-recreate --build
```

<br />

### Stop
```
  npm run stop
```  
or
```
  ./stop.sh
```  
or  
```
  docker-compose -f docker-compose.yml down
```

<br />

### Logs
```
  npm run logs
``` 
or
```
  ./logs.sh
``` 
or
```
  docker logs docker-ubuntu-rpa -f
``` 

<br />

## Changelog

The current changelog is provided here: **[CHANGELOG.md](CHANGELOG.md)**