function keypair = generateCSEAsymmetricMasterKey(~, varargin)
% GENERATECSEASYMMETRICMASTERKEY Method to generate a client-side key pair
% The returned key pair can be used for asymmetric client side encryption
% DiffieHellman, DSA and RSA keys can be generated by the underlying libraries
% however AWS support is only provided for RSA. RSA keys of a minimum
% length of 512 bits are required.
%
% Example:
%   myKeyPair = s3.generateCSEAsymmetricKey(512);
%   By default an RSA key of 1024 bit will be generated
%   myKeyPair = s3.generateCSEAsymmetricKey();
%
% The individual keys can be extracted from a keypair as follows:
%   privateKey = keyPair.getPrivate();
%   publicKey = keyPair.getPublic();
%

% Copyright 2017 The MathWorks, Inc.

%% Imports
import java.security.KeyPair
import java.security.KeyPairGenerator
import java.security.NoSuchAlgorithmException
import java.security.PrivateKey
import java.security.PublicKey
import java.security.SecureRandom


logObj = Logger.getLogger();

% validate input
p = inputParser;
p.CaseSensitive = false;
p.FunctionName = 'generateCSEAsymmetricMasterKey';

algorithm = 'RSA';
defaultBitLength = 1024;
% RSA at least requires 512 bits
checkBitLength = @(x) validateattributes(x,{'numeric'},{'>=',512});

addOptional(p,'bitLength',defaultBitLength,checkBitLength);
parse(p,varargin{:})
bitLength = p.Results.bitLength;

write(logObj,'verbose',['Generating asymmetric key pair: ', algorithm, ' ', num2str(bitLength), ' bit']);

% Generate asymmetric key pair defaults: RSA 1024 bit
keyGenerator = KeyPairGenerator.getInstance(string(algorithm));
srand = SecureRandom();
keyGenerator.initialize(bitLength, srand);
keypair = keyGenerator.generateKeyPair();


end