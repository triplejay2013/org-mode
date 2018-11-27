######################
#Function definitions#
######################
def ASCIIDepad(Number):
    n = Number.ndigits() % 3;
    if (n > 0):
        print("This is not a padded ASCII string\n");
    else:
        L = [((Number - (Number % (1000^i)))/1000^i)%1000 - 100 for i in range(Number.ndigits()/3)];
        N = "";
        for i in range(Number.ndigits()/3):
            N = chr(L[i]) + N;
    return(N);

def ASCIIPad(Message):
    K = (map(ord,reversed(Message)));
    le= len(K);
    x = [100+K[i] for i in range(le)];
    x = ZZ(x,1000);
    return(x);

def rsadecrypt(encr,decrexp,encrmod):
    D = power_mod(encr,decrexp,encrmod);
    N = ASCIIDepad(D);
    return(N);

def rsaencrypt(Message, encrexp, encrmod):
    A = ASCIIPad(Message);
    E = power_mod(A,encrexp,encrmod);
    return(E);

def ISAttack (R):
    n = R.ndigits()
    for j in range(1, n + 1):
        x=(R-(R % 10^j))/10^j
        p = gcd(x, R)
        if ((1 < p)and (p<R)):
            return(p)
    print "nonefound"
	
def NewLegendre(a,p):
    if is_prime(p):
        return (1+kronecker(a,p))/2
    else:
        print "2nd argument has to be a prime"
        
def BlockNumber(y,primelist):
    m=0
    for i in xrange(0,4):
        m = 2*m + NewLegendre(y,primelist[i+10])
    return m+1

def BlockContents(y,primelist):
    k=0
    for i in xrange(0,10):
        k=10*k+NewLegendre(y,primelist[i])
    return k

def KeyDiscover(ylist,primelist):
    c=10^10
    k=0
    for i in xrange(16):
        d=16-BlockNumber(ylist[i],primelist)
        k=k+(BlockContents(ylist[i],primelist))*(c^d)
    return int(str(k),2)
	
def isquare (n):
    if isqrt(n) ** 2 == n:
        return(True)
    return(False)

def isqrt(n):
    return int(floor(sqrt(n)))

def usqrt (n):
    ur = isqrt(n)
    if ur ** 2 < n:
        ur = ur + 1
    return(ur)

def OneLine (n, iter):
    for x in range(1, iter + 1):
        sq = usqrt(x * n)
        y = sq ** 2 % n
        if isquare(y) == True:
            t = isqrt(y)
            u = gcd(n, sq - t)
            print("Factor found in round {0} rounds".format(x))
            return(u)
    print("No factors found")

# key is: (p,g,b)
# M in this case is the ciphertext E
def egVerify(key, M, y, s):
    v1=(power_mod(y,s,key[0]) * power_mod(key[2],y,key[0])) % key[0]
    v2=power_mod(key[1],M,key[0])
    return v1==v2
	
def egSign(key, M, x):
    r = randint(1,key[0])
    while gcd(r,key[0]-1) != 1:
        r+=1
	#print("gcd(r:{},(p-1):{})={}".format(r,key[0]-1,gcd(r,key[0]-1)))
    y = power_mod(key[1],r,key[0])
    s = ((M-(x*y))/r) % (key[0]-1)
    return (y,s)
	
#Finds random number used in El Gamal signature
# Remember
# r=(M2-x*y)/s mod (p-1) **gcd(s,p-1) must equal 1**
def rDiscover(M,x,y,s,p):
	if gcd(s,p-1) == 1:
		return ((M-x*y)/s) % (p-1)
	print("Value for 'r' Could not be found")
	return 0
######################

description="""
Foundations of Cryptology
Assignment 10
The OTB (Office of Technology Busting) made special purpose computer chips for generating
El-Gamal signatures and covertly planted in each chip *14 prime numbers* to leak the *160-bit private
key of the signer*, *10 bits per signature*. The *last four prime numbers* are used to code which of the
sixteen blocks of 10 bits each is being leaked by the particular signature, and primes 1 through ten
leak these ten bits prime 1 leaks bit 1, prime 2 leaks bit 2, and so on.
Alice bought one of these chips and installed it in her computer. Here are the 14 covert prime
numbers planted in her chip:"""

primelist=	[2610874309742867231360502542308382199053675592825240788613991898567287,
		6881793749340807728335795394301261629479870548736450984003401594706373,
		8314906195914825136973281314862289454100745237769034410057080703111511,
		5127114594552921209928891515242515620324828055912854227507525717981667,
		7473570262981491527797413449568788992987500442157627511097882499376811,
		9062890227065912603127119521589474574157513825150650905007553408748219,
		2815984929359632269852681585809504709739738485231104248045693804710167,
		8302655538010818866476054310788175542136407374106205605523687223947057,
		5812242019121022573901665288968349097396414947780422731613987785640429,
		4198272844134050365811754869582636140810856859347877704841433599229643,
		8724880795485531802023255050614524952922474293642065329619154912668053,
		6069438450681407641506962917791070874166946435905950292905549552889463,
		4125842236067060541266621757734462223575905687273574099511410424381497,
		9501247275887974857856234450269247606386273485070460241146322057229349]

description="""
Alice regularly corresponds with Lucy using the following protocol. They encrypt messages for
each other using the RSA crypto-system, and sign these messages using the El-Gamal system.
Lucy's RSA public key is as follows:"""
rsa_lkey={'n':1380329510951197510100010724038844435804781490991185453524669, 'e':431452543435309613375031056399003408107128387827408402715967, 't':0}
n=rsa_lkey['n']
e=rsa_lkey['e']
p=OneLine(n,10) # Private RSA key
q=n/p
phi=(p-1)*(q-1)
t=inverse_mod(e,phi)
rsa_lkey['t']=t; t

#Alice's El-Gamal signature key is as follows:
eg_akey={'p':10000000000000000000000000000000000000000000000000000000000000000005707, 'g':2, 'b':5829711445814756593150837441577049879646826835967016234521362166032923}
#p-1 == p
n=eg_akey['p']-1
p=ISAttack(n)
q=n/p

description="""
Here are sixteen messages from Alice to Lucy which have been collected by the Cyber Forensics
unit of the OTB: (E is the RSA - encrypted message, and y and s have their usual meanings in the
context of El-Gamal signatures: s is the result of signing the padded ASCII version of the message.)
"""

M1={'E':1134781463560674835061224378575070131233310977090840813092301,'y':6355654156581339292380028178295946379397857230419335473049773634105011, 's':9165085756767321557707624388546095482608475475072419124793930216287642}
M2={'E':348526314010735292619330553642899978920623570033772324649849,'y':6157738735079726271974947267390448530039834693941568486254984166399169, 's':7580596732923277682277308429550458486421120322969733810425808677713063}
M3={'E':144280751261655647389997303952062412262367552233518955034975,'y':9335313663168312334842734241780762294755281133475486862667663109265693, 's':902452660748342094448043076348013766357745134358961491151947971831298}
M4={'E':448648149210542717563843830926466689272194100737881817695849,'y':5666312454503499142803478855324287143700047631332918051757975784387852, 's':2339212545643638702289301089883628788751421175252652804149103380819500}
M5={'E':414463904058626538164714974954260575549577988440230717028375,'y':8609729555305475123927447895155480568383891784974360653476349663970219, 's':7542295030958909202194788901128163331877935875245454365944680358801016}
M6={'E':762798455103578108350927164584389075158784895748140579440858,'y':7365404439138911411864937298776875814102498525963049435105763372378772, 's':1606771469519514190569490683909892293358374332166482060564995247015982}
M7={'E':1176909860227801331876617938268884763814085436948672573185440,'y':5705440343386587753765002035968279773205391692599442025007820809081663, 's':795056909654530610475130199155990661441694481486389575943239181360163}
M8={'E':1038784868243291703163122137403638880051390504859030077046832,'y':9139181219517140532824520580591540432442737355121485514849816985670182, 's':718431597798222122752848311170876804983108930346831880471325577707750}
M9={'E':534307298423793561315454335890652994099216705910796252757003,'y':3851953190357247351746340095276683473382065321260493360272121028908078, 's':4425969620597187781028255597865205402426141520827972218693653450885014}
M10={'E':294792873244090595225360406826078427911073375481311873865117,'y':8332119728236605996252741802820164399490394892793656670206410123540806, 's':5683798202666903152470108694640039089754745733985049884601886790614149}
M11={'E':1355904422553023580096618287264066452910577884654954174043845,'y':1090916439028367923335435833686239225083325662650219511577614470087626, 's':3486112167704760872711104718953680515027994408104257306046727398596982}
M12={'E':528414128418567725915368190435344574500994961365177769853400,'y':4044337428348522271547535017777415980322724356426081427629324943634693, 's':1280391621642407995368091574204252749818718773673779092796712310184877}
M13={'E':382048408707112057090584331184203176355530469092303817253852,'y':5047503978916103346914776520107614498353295441864520623517103573476005, 's':6622497751951716014580838234980317172956294365936998965231635552650598}
M14={'E':1138109602667405943072422513690232405305131283131822608386662,'y':3079609686866100016134750688150613028636970390199280613932162055042282, 's':7651064433223341671855042720940102025407140854125385153059255930291852}
M15={'E':648551792358033195908225921930717188912777934403051076101283,'y':2507949926452818146783101167935559217583543852145717090862513023080430, 's':1876892947883839710552556001755856886960301874237874824837728826983258}
M16={'E':1108329618226979748565921595052080391831955721135843401833413,'y':1137237284834714268920432440084126521105380025168123492652543171722168, 's':4974270349376072715089518021560121124590346430908794289954437585093573}
M=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,M13,M14,M15,M16]
y=[i['y'] for i in M]
s=[i['s'] for i in M]
E=[i['E'] for i in M]
p=primelist


#The following replicates info from Blackboard:Software:Legendre-CoCalc
#This discovers 'x'? - verify somehow
x=KeyDiscover(y,p); x # Takes about 20s to compute
#1290003348882681184907543014445365590610205625395L

#Example Usage of Block leakage
#BlockNumber(y[0],p) #Quick computation
#BlockContents(y[0],p)
#for i in range(16):
#	bc = BlockContents(y[i], p)
#	print (BlockNumber(y[i],p), bc)
	
# Decrypt messages sent to Lucy using Lucy's private key:
#for i in M:
#	mi=rsadecrypt(i['E'],rsa_lkey['t'], rsa_lkey['n']); mi

# Remember r = (M-x*y)/s mod (p-1); use rDiscover(M,x,y,s,p), to find each random number

#From this information determine:
#1. Lucy's private RSA key;
	#361305388410523
#2. Alice's private El-Gamal key;
	#x=1290003348882681184907543014445365590610205625395L
#3. All the messages from Alice to Lucy;
mes=[
	'Trust the OTB!',
	'I trust them.',
	'They make chips',
	'for signatures.',
	'Did you get it?',
	'I may visit.',
	'Perhaps not.',
	'Stay cool.',
	'Say nothing.',
	'Good move!',
	'Change keys.',
	'Bob cracked it',
	'Maybe also Jack',
	'Mine are safe.',
	'Uh-oh...',
	'They are not?']
#4. All the random numbers used by Alice during signature generation.
#rDiscover(M,x,y,s,p):
r=[]
for i in range(len(mes)):
	r.append(rDiscover(ASCIIPad(mes[i]), x, y[i],s[i], eg_akey['p']))
	print(str(i+1) + ". " + str(r[i]))
randomNumbers="""
1. 0
2. 279609980683956300275566144892650827765370570419
Value for 'r' Could not be found
3. 0
Value for 'r' Could not be found
4. 0
Value for 'r' Could not be found
5. 0
Value for 'r' Could not be found
6. 0
7. 561632179750555610745205884336981428558537921825
Value for 'r' Could not be found
8. 0
Value for 'r' Could not be found
9. 0
10. 660302497351884884272183075684764705268237246717
Value for 'r' Could not be found
11. 0
12. 424540208662980822891917406935720503852329046165
Value for 'r' Could not be found
13. 0
Value for 'r' Could not be found
14. 0
Value for 'r' Could not be found
15. 0
16. 1304740743478692639491729486909033636608504466639
"""
s=((ASCIIPad(mes[1])-x*y[1])/r[1]) % (eg_akey['p']-1); s #This is the correct 'r'
