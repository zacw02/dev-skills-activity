# Rocket Media Developer Activity



Your task is to create a one-page, one-component website powered by Craft CMS.

- Create a new Craft project and code the following component.
- Integrate it with the CMS so that all the component content can be edited in Craft 
- For the frontend, use the Tailwind CSS utility library. You may also write custom CSS if necessary, but try to use Tailwind as much as possible.
- Use images from https://picsum.photos.
- For extra credit, modify your project to allow for collapsible content. Don’t feel pressured to do this.
- Target IE11, Edge, Firefox, Chrome, Safari, latest iOS and Android.
- `docker exec dev-activity_db mysqldump craftcms > db.sql`
- Push your project to github and email the link to x@rocketmedia.com.
- Email garrett@rocketmedia.com with questions.

What I’m looking for:

Sensible document structure and semantic HTML tags.
Construction that can handle different amounts of content.
Flexible and intuitive editing options in Craft CMS.
When it comes to margin/padding, I’m not looking for pixel-perfection. Use Tailwind’s default spacing values to approximate.
If you do the extra credit. Accessible: keyboard navigable and screen reader friendly. You can do it with vanilla JS, or jQuery.

# Prerequisites
- Install Docker Desktop (https://www.docker.com/products/docker-desktop)
- Install composer (https://getcomposer.org/)

# Installation

1. Fork this repository and clone to your computer.
2. Within the project, rename `.env.example` to `.env`
3. Run `composer install`
4. Run `docker-compose up -d` to start the Docker container
5. In your browser, open `http://dev-activity.127.0.0.1.nip.io:8080/admin/install` and follow the prompts to install Craft CMS.
6. When Craft installation is complete, open `http://dev-activity.127.0.0.1.nip.io:8080/` to view your website locally.

# Submission
When you're ready to submit your project:
1. From the root of your project, run `docker exec dev-activity_db mysqldump craftcms > db.sql`. This will export your Craft database to a file that I can import on my local machine to evaluate your work. If you make any additional changes to Craft, you'll need to re-run the command the dump the latest version of the database.
2. Commit all changes and push to Github.
3. Email garrett at rocketmedia dot com letting me know.
