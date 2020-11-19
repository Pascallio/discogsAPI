# discogsAPI

### Introduction
Unofficial R client of the discogs developers API, which can be found here https://www.discogs.com/developers. Using the API, information about releases and the martketplace can be obtained. 
This package fully supports all functions, including throttling calls and authorization through OAuth or a personalized token.

### Installation
Installation can be done by using `devtools`.

```{r}
install.packages(devtools)
devtools::install_github("Pascallio/discogsAPI")
```
This package relies on the `httr` package for making api calls and authorization, and `jsonlite` for parsing the response into R lists. 

### Getting started
While calls can be made without authorization, it limits the amount of calls to 25 / minute, while fully authorized calls increase the amount to 60 / minute. Authorization is therefor strongly recommended. 

#### Personal use
For personal use, get a personal access token at https://www.discogs.com/settings/developers which can be used to supplement the api calls. An example:

```{r}
# Get the number for sale for release id '1'
my_token <- "abc123def456"
release <- get_release(1, my_token)
print(release$num_for_sale)
```

#### Public use
For public use (e.g. an RShiny app), register your application at https://www.discogs.com/settings/developers to obtain an OAuth key and secret. Use these to authorize users using the `authorize` function. This function will halt the code untill the user has succesfully authorized the app. The Token object returned from the `authorize` function can be used just as a personal access token:

```{r}
# Get the number for sale for release id '1'
my_key <- "abcde1234"
my_secret <- "secret9876"
my_token <- authorize(my_key, my_secret)
release <- get_release(1, my_token)
print(release$num_for_sale)
```

### Details
Documentation about each function can be found in the manuals or for complete documentation, see https://www.discogs.com/developers
