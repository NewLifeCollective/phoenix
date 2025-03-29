# server functions

## registerTransaction
```lua
registerTransaction(iban, amount, note, type, name)
```
- iban: `string` account iban
- amount: `number`
- note: `string`
- type: `deposit` | `withdraw` | `receive` | `send`
- name: `string`

## addBalance

```lua
addBalance(iban, amount, data)
```
- iban: `string` account iban
- amount: `number`
- data: {
      transaction: `boolean` whether to register transaction or no
      note: `string` transaction note (this need `transaction` to be true)
      removeCash: `boolean` if true, it will remove cash from player
  }
## removeBalance
```lua
removeBalance(iban, amount, data)
```
- iban: `string` account iban
- amount: `number`
- data: {
      transaction: `boolean` whether to register transaction or no
      note: `string` transaction note (this need `transaction` to be true)
      addCash: `boolean` if true, it will add cash to player
  }

# client functions
## openBank

```lua
export['nfs-banking']:openBank()
```

# Events
## Client
#### This will trigger if player make a deposit/withdraw/transfer on banking
```lua
RegisterNetEvent('nfs-banking:client:cardAction', function(data)

end)
```

- data: {
    amount: `number`, 
    iban: `string`, 
    type: `string`, 
    note: `string`, 
    iban: `string`
    to_iban: `string`
}

#### This will trigger if player hides bank
```lua
AddEventHandler('n4s_banking:hideBank', function()

end)
```

#### This will trigger if player opened banking
```lua
AddEventHandler('nfs-banking:client:bankOpened', function()

end)
```
## Server
#### This will trigger if player opened banking
```lua
RegisterNetEvent('nfs-banking:server:bankOpened', function()

end)
```

# state bag

```lua
local isBankOpen = LocalPlayer.state.bankOpen
```
