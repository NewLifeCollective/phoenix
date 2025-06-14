return {
  reissueFee = 5000,
  atmDistance = 2.0,
  savingInterest = 2,         --percent
  itemName = 'bank_card',
  managementJob = 'police',   -- job needed to open management
  managementCommand = 'bankmanagement',
  cardsLimit = 3,
  savingLogs = true,
  progressBar = function()
    return lib.progressBar({
      duration = 3000,
      label = 'Showing Information..',
      useWhileDead = false,
      canCancel = true,
      disable = {
        car = true,
      },
      anim = {
        dict = "amb@prop_human_atm@male@enter",
        clip = "enter",
      },
    })
  end,

  translation = {
    openBank = 'Open Bank',
    wrongIban = 'Iban is wrong',
    getCardError = 'Failed to get card with iban: ',
    frozenCard = 'Card is frozen : ',
    wrongPin = 'Wrong PIN',
    selfTransfer = 'Can\'t transfer to yourself',
    playerNotFound = 'Couldn\'t get player',
    noCash = 'You don\'t have enough cash',
    noAccountCash = 'Account don\'t have enought cash',
    hookFailed = 'Operation failed by hook',
    cardsMax = 'You have reached the maximum amount of cards',
    noMoney = 'Not enough money!',
    cantDelete = 'You can\'t delete main card',
    noMainCard = 'Couldn\'t get player main card ',
    noSaving = 'No saving account found',
    noAmount = 'You dont have that amount',
    wrongAmount = 'You dont have that amount',
    loanDuplicated = 'You already have a loan',
    acceptedLoan = 'Your loan is accepted!, the requested amount is in your main card balance',
    cardBalance = 'You have $%s in your main card',
    dontHaveMainCard = 'You dont have a main card',
    overview = {
      { day = 'Sun' },
      { day = 'Mon' },
      { day = 'Tue' },
      { day = 'Wed' },
      { day = 'Thu' },
      { day = 'Fri' },
      { day = 'Sat' }
    }
  }
}