# cui-about.me
The hacker's profile downloader for your terminal

Prints how to use this service.

```sh
$ curl http://cui-about.me
```

Prints names of all users.

```sh
$ curl http://cui-about.me/users
```

Prints a user's profile.

```sh
$ curl http://cui-about.me/[username]
```

Prints a user's profile like man.

```sh
$ curl http://cui-about.me/[username]/man
```

Prints a specific item of a user's profile.

```sh
$ curl http://cui-about.me/[username]/[item]
```

Signup you with name, password and any infos. Name and password are required.

```sh
$ curl -X POST -d 'name=[yourname]' -d 'password=[password]' [-d '[field]=[value]'] http://cui-about.me/signup
```

Update your profile. Password is required.

```sh
$ curl -X PUT -d 'password=[password]' [-d '[field]=[value]'] http://cui-about.me/[yourname]
```

If you want to delete items, update the values of the items into blank.
For example, if you want to delete `foo` item, you will only run a command like this:

```sh
$ curl -X PUT -d 'password=[password]' -d 'foo=' http://cui-about.me/[yourname]
```

Delete your profile. Password is required.

```sh
$ curl -X DELETE -d 'password=[password]' http://cui-about.me/[yourname]
```
