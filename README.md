# configuration
my common configuration

- rpmfusion
http://rpmfusion.org/Configuration

# performance
- msata
```
#dd if=/dev/zero bs=8M of=aa.txt count=1024
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB) copied, 24.9653 s, 344 MB/s

#samung 850 EVO
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB) copied, 23.9752 s, 358 MB/s
```
- sata3
```
#dd if=/dev/zero bs=8M of=aa.txt count=1024
1024+0 records in
1024+0 records out
8589934592 bytes (8.6 GB) copied, 13.0056 s, 660 MB/s
```
