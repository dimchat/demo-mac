# Secure Chat (Mac version)

Demo project of DIM Client, just for study purpose.

Dependencies:

- [DIM Client (client-objc)](https://github.com/dimchat/client-objc)
	- [DIM Core (core-objc)](https://github.com/dimchat/core-objc)
		- [Message Module (dkd-objc)](https://github.com/dimchat/dkd-objc)
		- [Account Module (mkm-objc)](https://github.com/dimchat/mkm-objc)
	- [Connection Module (moky/StarGate)](https://github.com/moky/StarGate)
		- [Tencent/mars](https://github.com/Tencent/mars)
	- [Finite State Machine](https://github.com/moky/FiniteStateMachine)

## Getting started

### 0. Download source codes and requirements

```
cd GitHub/
mkdir dimchat; cd dimchat/

# demo source codes
git clone https://github.com/dimchat/demo-mac.git

# requirements
git clone https://github.com/dimchat/client-objc.git
git clone https://github.com/dimchat/core-objc.git
git clone https://github.com/dimchat/dkd-objc.git
git clone https://github.com/dimchat/mkm-objc.git

cd ..; mkdir moky; cd moky/
git clone https://github.com/moky/StarGate.git
git clone https://github.com/moky/FiniteStateMachine.git
```

### 1. Run it

Just open `dimchat/demo-mac/Sechat/Sechat.xcodeproj`
