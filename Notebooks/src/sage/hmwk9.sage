###########################
# RSA & EL GAMAL Functions#
###########################
def ASCIIPad(Message):
	K = (map(ord,reversed(Message)));    
	le= len(K);
	x = [100+K[i] for i in range(le)];
	x = ZZ(x,1000);
	return(x);
	
def ASCIIDepad(Number):
	n = Number.ndigits() % 3;
	if (n > 0):
		print("This is not a padded ASCII string\n");
	else:
		L = [((Number - (Number % (1000^i)))/1000^i)%1000 - 100 for i in range(Number.ndigits()/3)];
		N = "";
		for i in range(Number.ndigits()/3):
			N = chr(L[i]) + N;
		return(N)
		
def rsaencrypt(Message, encrexp, encrmod):
	A = ASCIIPad(Message);
	E = power_mod(A,encrexp,encrmod);
	return(E);

def rsadecrypt(encr,decrexp,encrmod):
	D = power_mod(encr,decrexp,encrmod);
	N = ASCIIDepad(D);
	return(N);

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
	
def isqrt(n):
    return int(floor(sqrt(n)))

def usqrt (n):
    ur = isqrt(n)
    if ur ** 2 < n:
        ur = ur + 1
    return(ur)

def FermatAttack (n, rounds):
	st = usqrt(n)
	for x in range(st, st + rounds + 1):
		#print (x-st)
		sq = x ** 2 - n
		y = isqrt(sq)
		if y ** 2 == sq: 
			print "Factor found in round {0}".format(x-st+1)
			return(x + y)
	print "No factor found in {0} rounds".format(rounds)
	return 0
###########################

# IMPORTANT!!
# RSA is used to encrypt the below messages, El Gamal to sign them
# Alice and Bob  are secretly sharing Alice's private El-Gamal key to maintain a covert channel of communication

##############################################
# Information given in assignment description#
##############################################
# RSA KEYS
# Alice's Key
rsa_akey={'n':11739085287969531650666764880307069646178466406116413,'e':29}
# Bob's key
rsa_bkey={'n':46956341151878126602666849327932976850293104473816077, 'e':71}
# Jack's key
rsa_jkey={'n':105651767591725784856000289747489691397274520258086741,'e':113}
# Lucy's key
rsa_lkey={'n':187825364607512506410666935319870481320981631530945317, 'e':173}
rsa_keys=[rsa_akey,rsa_bkey,rsa_jkey,rsa_lkey]

# El Gamal Keys
# Alice's Key
eg_akey={'p':11739085287969531650666764880307069646178466406133747, 'g':122 ,'b':4559251933765135908042850372269050947311088678478407}
# Bob's Key
eg_bkey={'p':46956341151878126602666849327932976850293104473818163, 'g':14646,'b':41773094887790182197984303656431777160492104718067730}
# Jack's Key
eg_jkey={'p':105651767591725784856000289747489691397274520258105207,'g':1771562,'b':77714098443250567285634413412177559464041605041509476}
# Lucy's key
eg_lkey={'p':187825364607512506410666935319870481320981631530959327,'g':214358883,'b':14644041014569643811484259591673998237151900979559891}
eg_keys=[eg_akey,eg_bkey,eg_jkey,eg_lkey]

# Alice's private El Gamal Key (x) - shared with bob for covert channel
eg_apkey=7699542093548349244049573757501851670562589091966419

# RSA Encrypted Message E | y=g^r mod p | s=(M-x*y)/r mod (p-1)
unknown1={'E':115251811749469530248002415406523254651489743459017725,'y':19240616197970611747502124859803652312085074442112010,'s':32706719515423467589632843847126484468195520962513517}
unknown2={'E':19659961695727243828141973694524447795978653272532149, 'y':50397128494149821593269937078000120329058172709578908,'s':47844269820223698406809962518912128051231159162499240}
unknown4={'E':126624117419296887665831621310305588878545225870594430,'y':9352666161952933766287125798193970300698629396417740,'s':4002797869345137661356168947662543489885815101905269}
unknown3={'E':1199064630279469528093193372862416429357320708704542,'y':105216848703587739343303886089914553038944537874501648,'s':139693573510952382531551260015801085872053556486585886}
unknowns=[unknown1,unknown2, unknown3, unknown4]

# Alice's message search
print("Alice's Message Search Results")
rsa=(rsa_akey['n'],rsa_akey['e'])
eg=(eg_akey['p'],eg_akey['g'],eg_akey['b'])
x=eg_apkey

# El Gamal Signature Verification
M=ASCIIPad("Done!")
S=egVerify(eg,M,unknown4['y'],unknown4['s']); S

# Fermat Attack Attempt
n=rsa[0]
e=rsa[1]
p=FermatAttack(n,10); p
q=n/p; q
phi=(p-1)*(q-1)
d=inverse_mod(e, phi)

# Bob's message search
print("Bob's Message Search Results")
rsa=(rsa_bkey['n'],rsa_bkey['e'])
eg=(eg_bkey['p'],eg_bkey['g'],eg_bkey['b'])

# Fermat Attack Attempt
n=rsa[0]
e=rsa[1]
p=FermatAttack(n,10); p
q=n/p; q
phi=(p-1)*(q-1)
d=inverse_mod(e, phi)
M=rsadecrypt(unknown2['E'], d, n); M
M=rsadecrypt(unknown3['E'], d, n); M

# El Gamal Signature Verification
M=ASCIIPad("Buy IBM")
S=egVerify(eg,M,unknown1['y'],unknown1['s']); S

# Jack's message search
print("Jack's Message Search Results")
rsa=(rsa_jkey['n'],rsa_jkey['e'])
eg=(eg_jkey['p'],eg_jkey['g'],eg_jkey['b'])

# El Gamal Signature Verification
M=ASCIIPad("Sell AT&T")
S=egVerify(eg,M,unknown2['y'],unknown2['s']); S

# Lucy's message search
print("Lucy's Message Search Results")
rsa=(rsa_lkey['n'],rsa_lkey['e']) eg=(eg_lkey['p'],eg_lkey['g'],eg_lkey['b'])

# El Gamal Signature Verification
M=ASCIIPad("Sell all")
S=egVerify(eg,M,unknown3['y'],unknown3['s']); S

# Fermat Attack Attempt
n=rsa[0]
e=rsa[1]
p=FermatAttack(n,10); p
q=n/p; q
phi=(p-1)*(q-1)
d=inverse_mod(e, phi)
M=rsadecrypt(unknown1['E'], d, n); M
M=rsadecrypt(unknown4['E'], d, n); M
############################################

# 1) Determine each Message
# 2) Determine For whom each message was intended
# 3) Determine from whom each message is, by verifying the corresponding El Gamal Signatures
oneThruThree="""
| Message     | To Whom                        | From Whom               |
|-------------+--------------------------------+-------------------------|
| Fermat      | Decrypted using private key of | verifying El Gamal Sigs |
|-------------+--------------------------------+-------------------------|
| "Buy IBM"   | Lucy                           | Bob                     |
| "Sell AT&T" | Bob                            | Jack                    |
| "Sell all"  | Bob                            | Lucy                    |
| "Done!"     | Lucy                           | Alice                   |
"""
# 4) Determine any messages Alice passed covertly to Bob through her El Gamal Signature
