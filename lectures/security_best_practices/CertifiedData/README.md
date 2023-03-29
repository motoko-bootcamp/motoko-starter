# Certified Data

In this example, we have a simple counter canister ```certified_data```. 

The canister exposes an update method ```inc``` to increment to the counter by 1 and set the new certificate for the counter using ```CertifiedData.set```. A query method ```val``` is also available to read the counter along with certificate retrieved via ```CertifiedData.getCertificate()```

### Example 

```
$ dfx deploy 

$ dfx canister call certified_data inc
(1 : int)

$ dfx canister call certified_data inc
(2 : int)

$ dfx canister call certified_data val
(
  record {
    certificate = opt blob "\d9\d9\f7\a2dtree\83\01\83\01\83\01\83\02Hcanister\83\01\83\01\82\04X \8e\c6\d0s\92\8f\07\1d\d4\1b\ac-0\f5\fc\9a\8c\90,\1c\b3~\bb\ffK\f5D-hh>+\83\02J\00\00\00\00\00\00\00\01\01\01\83\01\83\01\83\01\83\02Ncertified_data\82\03A2\82\04X \83\c5k\f1M\de=(\def\c6\92\b5\fc\9d\97\e9\dd\98[j\d7+\0f\e6\f8N\8a\8d\f3\dc\b2\82\04X m\df8A\0eRHcQ \aa\01\a4If\e4\01jV_\b5:l\ee,\a6st\d1\bc*\ca\82\04X \00\eb@\c3\f2\80\d86\c7\ce\bf\b1\a4\c0\e55\11\c2\bf\ee>\a2Z<#T\16\ea\a7\f9\bcc\82\04X \22\a1Kw\14\82\05\a0\b9\bf\d4T\b3\b5\02\d0yP~>\e2\00\9e\d8HO;\96\03\97&I\82\04X l\0f\fb\fcU\a3y\83C\c9l\8d\13\db%\d5\bb=.\82\c8P\be\0d\b5\f8\814\ef\5c\f8\fb\82\04X \f3]\d1\d3\e9\bcU\9eQ\d2m\f1\9d\f3t\86\bf6Am\82g/\f9\e1\b5\df\a4\5c;O\f6\83\01\82\04X \d7\dc\fb\d6 \c0\029\dd\09\978C\fd\0e\08\95\fas9\92h\d3t\c8\04\eb\8ds\a2bD\83\02Dtime\82\03I\b0\bc\e6\c9\fe\b3\ff\9d\17isignatureX0\97\e6H6;+\de\d1\11U\86\94\a7\e9Yi\87\0f6\af\cf\80\cf\dc\e1{#^\de\14&\9c\15H\aa\07\88\03[\9c\b3r\09lO\96O\ce";
    value = 2 : int;
  },
)

```