# Functions used are defined under "Software" on blackboard and are not provided here for brevity


# Encrypted then signed OR signed then Encrypted
E1=192673410575232178904649776915190700998989853537815830553230611421742385992522416989509275862058211339709950929
E2=11086722953882983852431944511576952516550372827816915921973944718976810268666675210351469628970964240272091459974947601880432783056689928327962090547865754927288993076429
E3=1834496602541743526158189555689903156371898111774868041164889421551770983263334034443653217840819146984865628720631961622548297373876065576

#key=(0,1,2  ,3)
#key=(n,e,phi,t)
keyA=(76658177305027745952631719056705996813842536289251500683261184543556255161304991640490427342739196690985988361653741113103098879695402379917606571643825715761882994534703,324382479328749283092183091832019840198400001)
keyB=(305305799846472299868002515458930157177903223108162710252913053729390747860737704417309741537399438511250989442729880781658025831833386498939,349874928174912837921492180000001)
keyD=(61823435968160437417469491157734955693190192084429162238180686630269127581382430522764865425365025843237298546732978005917453969903,3843243287434824441111878911001,61823435968160437417469491157734955693190192084429162238180686622392533899929241536658509172593305085911230229647058820648322486488)
t=inverse_mod(keyD[1],keyD[2])
keyD+=(t,)

#Alice Signs
E=power_mod(E2,keyA[1],keyA[0])
M=rsadecryptS(E,keyD[3],keyD[0])
print("ALICE: {}".format(M))

#Alice Signs
S=rsadecrypt(E3,keyD[3],keyD[0])
M=power_mod(S, keyA[1], keyA[0])
M=ASCIIDepad(M)
print("ALICE: {}".format(M))

#Bob Signs
S=rsadecrypt(E3,keyD[3],keyD[0])
M=power_mod(S, keyB[1], keyB[0])
M=ASCIIDepad(M)
print("Bob: {}".format(M))
