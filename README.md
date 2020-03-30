# Rocket Media Developer Activity

Your task is to create a one-page website powered by Craft CMS featuring a single, responsive component.

- Create a page containing the component shown in `dev-activity.png`
- Integrate it with the CMS so that all the component content can be edited in Craft 
- For the frontend, use the [Tailwind CSS](https://tailwindcss.com/) utility library. You may also write custom CSS if necessary, but try to use Tailwind as much as possible.
- Use images from https://picsum.photos.
- For extra credit, modify your component to allow for collapsible content on small screens. Don’t feel pressured to do this.
- Target IE11, Edge, Firefox, Chrome, Safari, latest iOS and Android.
- Feel free to email Garrett with questions.

## What I’m looking for:

- Sensible document structure and semantic HTML tags.
- Construction that can handle different amounts of content.
- Intuitive field setup within Craft CMS.
- Not-too-permissive field setting within Craft; don't let your CMS users add content that will break the site!
- When it comes to margin/padding, I’m not looking for pixel-perfection. Use Tailwind’s default spacing values to approximate.
- If you do the extra credit, I'm looking for accessibility: keyboard navigable and screen reader friendly. You can do it with vanilla JS, or jQuery.

# Prerequisites
- Install Docker Desktop (https://www.docker.com/products/docker-desktop)
- Install composer (https://getcomposer.org/)

# Installation

1. Fork this repository and clone to your computer.
2. Within the project, rename `.env.example` to `.env`
3. Run `composer install`
4. Run `docker-compose up -d` to start the Docker container*. Count to twenty in your favorite foreign language to give the MySQL container time to boot.
5. In your browser, open `http://dev-activity.127.0.0.1.nip.io:8080/admin/install` and follow the prompts to install Craft CMS.
6. When Craft installation is complete, open `http://dev-activity.127.0.0.1.nip.io:8080/` to view your website locally.

\* _In order to make it easy for you to get a local PHP development server running, this project includes a Docker container. However, if you've ever used Docker, you know that sometimes it creates more problems than it solves. If you cannot get Docker working, feel free to use MAMP or any other local web server that works for you. Just be sure to include an export of your database as mentioned in step 1 of the submission instructions._

# Submission
When you're ready to submit your project:
1. On the command line, in the root of your project, run `docker exec dev-activity_db mysqldump craftcms > db.sql`.
2. Commit all of your work and push to Github.
3. Notify me (Garrett) via email that you're ready for me to review your work.
