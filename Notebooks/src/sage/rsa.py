def rsaencrypt(Message, encrexp, encrmod):
    A = ASCIIPad(Message);
    E = power_mod(A,encrexp,encrmod);
    return(E);

def rsadecrypt(encr,decrexp,encrmod):
    D = power_mod(encr,decrexp,encrmod);
    N = ASCIIDepad(D);
    return(N);

########################################################################################
# The ASCIIPad takes a string (plaintext) as an input and gives a number as an output. #
# The number is represented in a ASCII like format that is padded.                     #
########################################################################################
def ASCIIPad(Message):
    K = (map(ord,reversed(Message)));    
    le= len(K);
    x = [100+K[i] for i in range(le)];
    x = ZZ(x,1000);
    return(x);
#################################################################################################
# The input is a number and the output is the original message. If the input is not padded ASCII#
# version of a message it returns the value: "This is not a padded ASCII string"                #
#################################################################################################
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

def isASCIIPadded(Number):
    N = ""
    n = Number.ndigits() % 3;
    if (n > 0):
        return False;
    L = [((Number - (Number % (1000^i)))/1000^i)%1000 - 100 for i in range(Number.ndigits()/3)];
    for i in range(Number.ndigits()/3):
        if L[i] < 0:
            return False
        if L[i] > 255:
            return False
    return True
