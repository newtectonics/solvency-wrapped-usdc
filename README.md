# solvency-wrapped-usdc !! NOT TESTED !!

### This is an experiment in trustless cooperation during a bank run. 

## How it works

In order to prevent a bank run on USDC, large USDC holders could use the following smart contracts to wrap their USDC. Once cooperation from enough large USDC holders is confirmed, the token prevents unwrapping until the holders collectively decide that USDC has been made solvent again. It would give assurances to the greater USDC community that others would cooperate in preventing a bank run, which is bad for everyone.


- By depositing USDC, depositors are issued a wrapped USDC called swUSDC and vswUSDC.
- Once 3.3B USDC has been deposited, swUSDC locks and vswUSDC unlocks.

## BEFORE THE LOCK
- depositors can unwrap their swUSDC, which burns that amount of vswUSDC.

## AFTER THE LOCK
- No additional vswUSDC is minted.
- depositors can vote with their vswUSDC on whether or not to unlock the swUSDC.

If the lock happens, USDC is 100% solvent. This prevents a bank run and the vswUSDC has power over $3.3b of assets, giving it a small market value for a short period of time. If the market decides this value is enough to allow some vswUSDC holders to sell their tokens, and that value can cover the risk of not liquidating their USDC, the system would stabilize the USDC ecosystem.

Other devs, go for it on this. Tear it up. I spent an hour on it and now I'm gonna get ready to go see a movie. See ya in the next life.
