## Sparta Node Sample App

# Jenkins Merge Attempts
- Try 1 at just changing the README.
- Try 2.
- Try 3.
- Try 4.
- Trying after changing branches around in config file. 
- Maybe fixing wompwomp?

# Launching The App
- Attempt 1
- Attempt 2, after changing security rules. 
- Attempt 3, rebooted VM to apply security rules.
- Adding debug info to console output.
- Checked IP of jenkins server
- Relaxed security group rules.
- Attempt the 7th? 8th maybe?
- Archiving artifacts from job 2.
- Mayhaps my paths were a tad incorrect.
- Root directory????
- SCP is letting me down.
- Come on now.
- SCP is driving me mad.
- Womp
- I broked it.


## Description

This app is intended for use with the Sparta Global Devops Stream as a sample app. You can clone the repo and use it as is but no changes will be accepted on this branch. 

The app is a Node JS app with three pages.

### Homepage
- `192.168.10.100:3000`
``localhost:3000``

Displays a simple homepage displaying a Sparta logo and message. This page should return a 200 response.

### Blog

``localhost:3000/posts``

This page displays a logo and 100 randomly generated blog posts. The posts are generated during the seeding step.

This page and the seeding is only accessible when a database is available and the DB_HOST environment variable has been set with it's location.

### A fibonacci number generator

``localhost:3000/fibonacci/{index}``

This page has be implemented poorly on purpose to produce a slow running function. This can be used for performance testing and crash recovery testing.

The higher the fibonacci number requested the longer the request will take. A very large number can crash or block the process.


### Hackable code

``localhost:3000/hack/{code}``

There is a commented route that opens a serious security vulnerability. This should only be enabled when looking at user security and then disabled immediately afterwards

## Usage

Clone the app

```
npm install
npm start
```

You can then access the app on port 3000 at one of the urls given above.

## Tests

There is a basic test framework available that uses the Mocha/Chai framework

```
npm test
```

The test for posts will fail ( as expected ) if the database has not been correctly setup.
