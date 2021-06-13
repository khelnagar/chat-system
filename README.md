# Chat System


## Install Dependencies
1. Install Docker for Windows/Mac/Linux.


This project is fully containerized with Docker, meaning you need zero configurations on your local machine to run the app. 

## Running The App
1. CD to the root directory where docker-compose.yml exists.
2. Run `docker-compose up`. It may take a little while downloading new images.

This creates the below containers
- Rails app
- MySQL
- Sidekiq
- Redis
- Elasticsearch

## Example Requests

* New application

`
$ curl -X POST http://localhost:3000/applications  -H 'cache-control: no-cache' -H 'content-type: application/json' -d '{"name":"application1"}'
`

returns application application_token

* New chat

`
$ curl -X POST http://localhost:3000/applications/{application_token}/chats -H 'cache-control: no-cache' -H 'content-type: application/json' -d '{"application_application_token":{application_token}}'
`

returns chat number

* New message

`
$ curl -X POST http://localhost:3000/applications/{application_token}/chats/{number}/messages -H 'cache-control: no-cache' -H 'content-type: application/json' -d '{"application_application_token":{application_token},"chat_no":{number},"content": "new message"}'
`

returns message number

* Get application

`
$ curl -X GET http://localhost:3000/applications/{application_token} -H 'cache-control: no-cache'
`

* Search query

`
$ curl -X GET http://localhost:3000/applications/{application_token}/chats/{number}/search?q=new' -H 'cache-control: no-cache'
`
