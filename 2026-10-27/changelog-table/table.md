| | Intel i7-12700K | AMD EPYC 9255 | Apple M4 Max | Linux VM on the M4 Max |
|---|---|---|---|---|
| One message of 64 B | 0.8× | 1.1× | 1.5× | 1.1× |
| One message of 1 KiB | 1.1× | 1.1× | 1.2× | 1.2× |
| One message of 1 MiB, one thread | 1.0× | 1.2× | 2.5× | 2.5× |
| One message of 128 MiB, every core | 1.1× | 1.0× | 1.3× | 1.3× |
| A stream of 64 KiB messages, every core | 4.8× | 1.2× | 13× | 9.5× |
| A batch of 1024 messages, 64 B each | 1.1× | 1.1× | 1.9× | 1.8× |
| b3sum over 1000 files of mixed sizes | 3.4× | 5.8× | 4.6× | 26× |
