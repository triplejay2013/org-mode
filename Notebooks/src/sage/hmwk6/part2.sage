# Function Definitions
# REF: Blackboard Software (rsadecrypt)
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

def rsadecrypt(encr,decrexp,encrmod):
    D = power_mod(encr,decrexp,encrmod);
    N = ASCIIDepad(D);
    return(N);


# From Blackboard Software Sources (Fermat Attack)
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

# Define Problem information into code
# aliceKey=(R/n,e) where R or n is the modulos
aliceKey=(3200909051105364201164693808053590029074088922158723491051061550603549823737458227601881401901569257978004143012923593331603179164497963879113975835000986070024699519343049991253001543465847139349037243656109687211847515003135028132545450689475582835433024130454351048493271288284326740872991312817737068756145723348616748658487242931184584005382638341 ,45938274932874982748938989492800101)
n=aliceKey[0]
e=aliceKey[1]
bobM=1646965299225077453528764533325484870128106736546137408200095456059067040313170132659677309326733627254170824177278689792967869683703210102631692715251241388457103568881887427174337319839702934337074114069079964028787201219122008132800911350242389943062437915595376659222211331548822861710469042657218207369516502014847384607200570429591504554077212313

# Try a Fermat Attack on bob's message
p=FermatAttack(n,10)
p
# Find the prime factors of n
q=aliceKey[0]/p
phi=(p-1)*(q-1)

# compute private key
t=inverse_mod(e,phi)
t
	
# Attempt to decrypt the message
D=rsadecrypt(bobM, t, n)
D

print("The message is {}".format(D))
print("The private key is {}".format(t))
print("The value of phi(R) is {}".format(phi))
print("Factors of R are {} and {}".format(p,q))
