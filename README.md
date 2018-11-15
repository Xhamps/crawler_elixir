# CrawlerElixir


## Build

To build need running this command

```
$ mix escript.build
```

## Running

First you need build the application, after that you can execute the command to running.

```
$ ./crawler_elixir 
```

After that, will generator a file `links.json` in root folder with all links.

## Tunning

Some changes in the code help to running more fast, example:

This code is responsable to request de page, parse de html and find the links.
[First code](images/code1.png)

The time to running all crawler and save the json

[Time of first code](images/result1.png)

In this code I change to leave fater the code. I used the best tools of Elixir to running in parallel all requests.
[Second code](images/code2.png)

If witch this change we have decreased more than half the time.
[Time of second code](images/result2.png)