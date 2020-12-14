# {{site_name}}

## Summary
Describe your site here


## Setup
Install Ruby gems;
```
bundle install
```

Build site for first time;
```
bundle exec apogee build
```


## Repo Structure
Working files are available in the `/src` directory.

Rendered files are available in the `/dist` directory.


## Suggested development workflow
Install the LiveReload plugin/extension in your browser.

Start Guard in a terminal:
```
bundle exec guard
```

In your browser open `/dist/index.html`.

Connect the LiveReload plugin by clicking its icon in the browser.

Now you can edit files in the `/src` directory and the changes will be rendered
after each file save in the browser.

When you are finished with a development session, type `exit` in the guard 
session to end it.


## Apogee
More informantion about apogee available here:
[https://github.com/bdavi/apogee](https://github.com/bdavi/apogee)
