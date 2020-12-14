# Apogee

Apogee is a no-frill, no-configuration static site generator for when you need
to build a simple site fast and don't want to mess with more complicated
frameworks.


## Installation
Install it with:

```bash
$ gem install apogee
```


## Usage

### Create a site
You may create a new site from the command line with:
```bash
$ apogee new site_name
```

Your site is now fully configured and ready to use:
```
site_name
├── dist  <---------------- Rendered final site
├── Gemfile
├── Guardfile
├── README.md
└── src   <---------------- Working files
    ├── css
    │   └── styles.css
    ├── images
    ├── javascript
    │   └── script.js
    ├── layouts
    │   └── default.html
    └── pages
        └── index.html
```

### Build the final deployable site from your source files:
Render your deployable site using:
```bash
$ apogee build
```

Pages are rendered inside their respective layouts.

CSS and Javascript assets are combined and linked inside a layout.


### Tokens
Tokens can be used to specify a page's layout, as well as pass information from a page to its layout.


Apogee manages 4 tokens for you:
* `layout`: Specifies which layout file to use with a given page
* `css_bundle`: Specifies location in the layout to link the css bundle
* `js_bundle`: Specifies location in the layout to link the js bundle
* `page_content`: Specifies location in the layout to insert the page content

To pass additional information from a page to its layout, you may define arbitrary tokens 
in pages using a YAML format HTML comment.


Here is an example setup:

`src/pages/index.html`:
```html
 <!--
    layout: 'no_navigation'
    title: 'Welcome to Example Site'
 -->

 <h1>Hello, World<h2>
```


`src/layouts/no_navigation.html`:
```html
<html>
    <head>
        <title>{{title}}</title>

        {{js_bundle}}
        {{css_bundle}}
    </head>
    <body>
        <div>{{page_content}}</div>
    </body>
</html>
```


This would yield the following page when the site is built:

`dist/index.html`:
```html
<html>
    <head>
        <title>Welcome to Example Site</title>

        <script src="script.js"></script>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <div><h1>Hello, World<h2></div>
    </body>
</html>
```

### Using Guard to improve workflow
Sites created with Apogee come configured to work with [Guard](https://github.com/guard/guard) 
for automatic building and browser reloading.

The new site [README.md](https://github.com/bdavi/apogee/blob/main/lib/apogee/templates/new_site/README.md)
includes more detail on how to use Guard to speed up site creation workflow.


## Development

After you checkout the repo, run `bundle install` to install dependencies.

Then, you can run `bundle exec rspec` to run the tests.

Apogee uses a variety of tools to maintain code correctness, consistency
and quality. Before merging new code the expectation is:
* All specs pass
* 90% test coverage
* Adherence to the style guide
* Minimum 90% quality score on all code files

To verify the application run:
```
$ bin/verify
```

For more information about how to work with gems in development, see [https://guides.rubygems.org/make-your-own-gem/](https://guides.rubygems.org/make-your-own-gem/).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bdavi/apogee. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bdavi/apogee/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Code of Conduct

Everyone interacting in the Apogee project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bdavi/apogee/blob/master/CODE_OF_CONDUCT.md).
