**Meeting Room Scheduler**

**Overview**
Meeting room scheduler offers an impromptu meeting management tool. This tool for scheduling meetings provides a mechanism for better time planning and utilization. Availability of meeting schedulers eases the scheduling process and hikes productivity.

*Required ruby version 3.0.1*

**instruction to run the application**
`bundle install`
`rails db:create db:migrate` 
and then `rails server` or `rails s`

**run application through docker**
1. Make sure that docker is installed in your machine
2. Check `docker --version`
3. Install docker compose
  for linux
    ` sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
    and
    `sudo chmod +x /usr/local/bin/docker-compose`

4. Builds project images
    `docker-compose build`
5. Boots up the app
    `docker-compose up`
6. Create databases
  `docker-compose run rake db:create`
7. Run migrations
  `docker-compose run web rake db:migrate`
8. you can run your app at `localhost:3000`

<br><br>
*rdoc*
[documentation](https://meeting-room-scheduler-docs.web.app/MeetingsController.html)