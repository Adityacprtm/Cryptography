import random

def isPrime(num):
    if num == 2 or num == 3: 
        return True
    if num%2 == 0 or num < 2: 
        return False
    for i in range(3,int(num**0.5)+1,2):
        if num%i == 0: 
            return False
    return True

def gcd(a,b):
    while b != 0:
        a, b = b, a % b
    return a

def multiplicative_inverse(e, toti):
    d = 0
    x1 = 0
    x2 = 1
    y1 = 1
    temp_toti = toti

    while e > 0:
        temp1 = temp_toti//e
        temp2 = temp_toti - temp1 * e
        temp_toti = e
        e = temp2
        
        x = x2 - temp1 * x1
        y = d - temp1 * y1
        
        x2 = x1
        x1 = x
        d = y1
        y1 = y
    
    if temp_toti == 1:
        return d + toti

def setup(p,q):
    if not (isPrime(p) and isPrime(q)):
        raise ValueError('nilai p dan q harus prima')
    elif p == q:
        raise ValueError('nilai p dan q tidak boleh sama')
    #cari nilai n
    n = p * q
    #cari nilai totient
    toti = (p-1) * (q-1)
    #pilih e - 1 < e < toti
    e = random.randrange(1,toti)
    #cari fpb dengan euclidean gcd
    g = gcd(e,toti)
    while g != 1:
        e = random.randrange(1,toti)
        g = gcd(e,toti)
    #generate private key dengan euclidean
    d = multiplicative_inverse(e, toti)
    #Return public dan private keypair
    #Public key = (e, n) dan private key = (d, n)
    return ((e, n), (d, n))

def encrypt(pk, plaintext):
    #Unpack the key into it's components
    key, n = pk
    #Convert each letter in the plaintext to numbers based on the character using a^b mod m
    cipher = [(ord(char) ** key) % n for char in plaintext]
    #Return the array of bytes
    return cipher

def decrypt(pk, ciphertext):
    #Unpack the key into its components
    key, n = pk
    #Generate the plaintext based on the ciphertext and key using a^b mod m
    plain = [chr((char ** key) % n) for char in ciphertext]
    #Return the array of bytes as a string
    return ''.join(plain)

if __name__ == '__main__':
    print("RSA Encrypt / Decrypt")
    p = int(input("Masukan bilangan prima: "))
    q = int(input("Masukan bilangan prima lainnya: "))
    print("Generating your public/private keypairs now . . .")
    public, private = setup(p, q)
    print("Your public key is ", public ," and your private key is ", private)
    message = input("Enter a message to encrypt with your private key: ")
    encrypted_msg = encrypt(private, message)
    print("Your encrypted message is: ")
    print(''.join(map(lambda x: str(x), encrypted_msg)))
    print("Decrypting message with public key ", public ," . . .")
    print("Your message is:")
    print(decrypt(public, encrypted_msg))