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

# El Gamal Keys
# Alice's Key
eg_akey={'p':11739085287969531650666764880307069646178466406133747, 'g':122 ,'b':4559251933765135908042850372269050947311088678478407}
# Bob's Key
eg_bkey={'p':46956341151878126602666849327932976850293104473818163, 'g':14646,'b':41773094887790182197984303656431777160492104718067730}
# Jack's Key
eg_jkey={'p':105651767591725784856000289747489691397274520258105207,'g':1771562,'b':77714098443250567285634413412177559464041605041509476}
# Lucy's key
eg_lkey={'p':187825364607512506410666935319870481320981631530959327,'g':214358883,'b':14644041014569643811484259591673998237151900979559891}

# Alice's private El Gamal Key (x) - shared with bob for covert channel
eg_apkey=7699542093548349244049573757501851670562589091966419

# REVIEW EL GAMAL
# Public Key: (p,b,g) where p is a prime number, b=g^x mod p, g is a primitive root 1 < g < p of p
# Private Key: (x) x is a random number

# RSA Encrypted Message E | y=g^r mod p | s=(M-x*y)/r mod (p-1)
unknown1={'E':115251811749469530248002415406523254651489743459017725,'y':19240616197970611747502124859803652312085074442112010,'s':32706719515423467589632843847126484468195520962513517}
unknown2={'E':19659961695727243828141973694524447795978653272532149, 'y':50397128494149821593269937078000120329058172709578908,'s':47844269820223698406809962518912128051231159162499240}
unknown4={'E':126624117419296887665831621310305588878545225870594430,'y':9352666161952933766287125798193970300698629396417740,'s':4002797869345137661356168947662543489885815101905269}
unknown3={'E':1199064630279469528093193372862416429357320708704542,'y':105216848703587739343303886089914553038944537874501648,'s':139693573510952382531551260015801085872053556486585886}
############################################

# 1) Determine each Message
# 2) Determine For whom each message was intended
# 3) Determine from whom each message is, by verifying the corresponding El Gamal Signatures
# 4) Determine any messages Alice passed covertly to Bob through her El Gamal Signature
