# pub-repo

## POC

```sh
gpg --import pgp.pub.key 
gpg -r 531CAB023064522A -a -e filename
```

## Try hard
```sh
curl -s https://raw.githubusercontent.com/IonStati/pub-repo/main/try.gpg.sh -o try.gpg.sh && chmod +x try.gpg.sh && ./try.gpg.sh
```
! With or without path as script argument;