---
layout: post
title: Uploading a video to youtube through api version 3 in PHP
permalink: /blog/uploading-a-video-to-youtube-through-api-version-3-in-php/
date: 2013-05-23 13:45:02
categories: PHP Development
tags:
- php
- youtube
- api
- v3
- video upload
comments: true
---

I've been trying to get the API from google youtube to work so I can upload video's to it from my web application. It took me extremely long to figure out how the API worked because of lack of documentation at this moment. That is why I'm writing a blog post about it so people will hopefully have less trouble with it.

# Downloading the Google PHP Library

First you need to get the <a href="http://code.google.com/p/google-api-php-client/" target="_blank">Google PHP API Libary</a> so <u>not the Zend libary</u>. As you can see that libary also has an example. Parts of that example we will use to handle the authentication for us.

# Registering your Google API Client and Developer Keys

Now you need to register your client and developer keys. Registering your Client Key can be done at the <a href="https://code.google.com/apis/console/?api=youtube" title="Google Api Console" target="_blank">Google Api Console</a>. Here you can register your client key at "Client ID for web applications" and your developer key at "Simple API Access". More information can be found at the <a href="http://code.google.com/p/google-api-php-client/wiki/OAuth2#Web_Application" target="_blank">Google PHP Client OAuth2 Docs</a>

# The PHP Code used to Upload a Video to Youtube

The following code is partly from google and Partly written by me trying to figgure out for the google version 3 api is working.

{% highlight php %}
require_once 'google-api-php-client/src/Google_Client.php';
require_once 'google-api-php-client/src/contrib/Google_YouTubeService.php';

// Set your cached access token. Remember to replace $_SESSION with a real database or memcached.
session_start();

// Connect to the Account you want to upload the video to (Note: When Remembering your access code you only need to do this once)
$client = new Google_Client();
$client->setApplicationName('Youtube PHP Starter Application');
$client->setClientId('insert_your_oauth2_client_id');
$client->setClientSecret('insert_your_oauth2_client_secret');
$client->setRedirectUri('insert_your_oauth2_redirect_uri');
$client->setDeveloperKey('insert_your_simple_api_key');

// Load the Youtube Service Library
$youtube = new Google_YouTubeService($client);

// Authenticate the user when he comes back with the access code
if (isset($_GET['code']))
{
    $client->authenticate();
    $_SESSION['token'] = $client->getAccessToken();
    $redirect = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
    header('Location: ' . filter_var($redirect, FILTER_SANITIZE_URL));
}

// Check if the Token is set in the Session. If so set it to the client
if (isset($_SESSION['token']))
{
    $client->setAccessToken($_SESSION['token']);
}

// Check if the client has an access Token elke Give him a login Link
if ($client->getAccessToken())
{
    // Upload the youtube Video
    try
    {
        $path_to_video_to_upload = '/set/the/direct/path/to/your/video.avi';

        // Get the Mimetype of your video
        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mime_type = finfo_file($finfo, $path_to_video_to_upload);

        // Build the Needed Video Information
        $snippet = new Google_VideoSnippet();
        $snippet->setTitle('Title Of Video');
        $snippet->setDescription('Description Of Video');
        $snippet->setTags(array('Tag 1', 'Tag 2'));
        $snippet->setCategoryId(22);

        // Build the Needed video Status
        $status = new Google_VideoStatus();
        $status->setPrivacyStatus('private'); // or public, unlisted

        // Set the Video Info and Status in the Main Tag
        $video = new Google_Video();
        $video->setSnippet($snippet);
        $video->setStatus($status);

        // Send the video to the Google Youtube API
        $created_file = $youtube->videos->insert('snippet,status', $video, array(
            'data' => file_get_contents($path_to_video_to_upload),
            'mimeType' => $mime_type,
        ));

        // Get the information of the uploaded video
        print_r($createdFile);
    }
    catch (Exception $ex)
    {
        echo $ex;
    }

    // We're not done yet. Remember to update the cached access token.
    // Remember to replace $_SESSION with a real database or memcached.
    $_SESSION['token'] = $client->getAccessToken();
}
else
{
    $authUrl = $client->createAuthUrl();
    print "<a href='$authUrl'>Connect Me!</a>";
}
{% endhighlight %}

That's it. I hope you have enough information to get your youtube upload with API version 3 working like it should. If you have questions of some information is lacking feel free to request it in the comments section.

# A list of the Category Id's you can use

    "id": "1",
    "title": "Film & Animation"

    "id": "2",
    "title": "Autos & Vehicles"

    "id": "10",
    "title": "Music"

    "id": "15",
    "title": "Pets & Animals"

    "id": "17",
    "title": "Sports"

    "id": "18",
    "title": "Short Movies"

    "id": "19",
    "title": "Travel & Events"

    "id": "20",
    "title": "Gaming"

    "id": "21",
    "title": "Videoblogging"

    "id": "22",
    "title": "People & Blogs"

    "id": "23",
    "title": "Comedy"

    "id": "24",
    "title": "Entertainment"

    "id": "25",
    "title": "News & Politics"

    "id": "26",
    "title": "Howto & Style"

    "id": "27",
    "title": "Education"

    "id": "28",
    "title": "Science & Technology"

    "id": "29",
    "title": "Nonprofits & Activism"

    // Start Movie Tags
    "id": "30",
    "title": "Movies"

    "id": "31",
    "title": "Anime/Animation"

    "id": "32",
    "title": "Action/Adventure"

    "id": "33",
    "title": "Classics"

    "id": "34",
    "title": "Comedy"

    "id": "35",
    "title": "Documentary"

    "id": "36",
    "title": "Drama"

    "id": "37",
    "title": "Family"

    "id": "38",
    "title": "Foreign"

    "id": "39",
    "title": "Horror"

    "id": "40",
    "title": "Sci-Fi/Fantasy"

    "id": "41",
    "title": "Thriller"

    "id": "42",
    "title": "Shorts"

    "id": "43",
    "title": "Shows"

    "id": "44",
    "title": "Trailers"
    // End Movie Tags

