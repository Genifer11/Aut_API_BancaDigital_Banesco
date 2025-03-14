Feature: Transferir - Entre mis cuentas

  Background:
    * url 'https://test.api.ob.banesco.com.pa/transfer/v3/transfers/accounts'
    * def AccesToken = Java.type('utils.AccesToken')
    * def accessToken = AccesToken.getAccessToken()
    * print 'Access Token:', accessToken


    Scenario: Transferencia entre mis cuentas exitosa
      * def jsonRequest = read('classpath:APImethods/json/transferLocalSuccess.json')
      And header Authorization = 'Bearer ' + accessToken
      And header RequestId = '202207280085'
      And header ClientDt = '2022-07-28T18:15:37'
      And header UserId = 'USRBOLINPUT'
      And header ChannelId = 'WebBanking'
      Given request jsonRequest
      When method POST
      Then status 200

  Scenario: Transferencia entre mis cuentas exitosa con todos los datos de respuesta
    * def jsonRequest = read('classpath:APImethods/json/transferLocalSuccess.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200
    And match $.ApplicationId == "#string"
    And match $.Status.StatusCode == "M0000"
    And match $.Status.StatusDesc == "OK"


  Scenario: Transferencia exitosa a otros bancos Bancolombia
    * def jsonRequest = read('classpath:APImethods/json/transferToAnotherBankBancolombia.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200
    And match $.Status.StatusCode == "M0000"
    And match $.Status.StatusDesc == "OK"

  Scenario: Transferencia local sin el dato de tipo de transferencia
    * def jsonRequest = read('classpath:APImethods/json/transferLocalWithoutTransferType.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200
    And match $.Status.StatusCode == "#string"


  Scenario: Transferencia a otro banco sin cuenta destino
    * def jsonRequest = read('classpath:APImethods/json/transferWithoutDestinationAccount.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200
    And match $.Status.StatusCode != "M0000"

  Scenario: Transferencia a otro banco con un codigo de tipo de transferencia incorrecto que no existe
    * def jsonRequest = read('classpath:APImethods/json/transferWithoutDestinationAccount.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200
    And match $.Status.StatusCode != "M0000"


  Scenario: Transferencia a otro banco sin nombre completo del beneficiario
    * def jsonRequest = read('classpath:APImethods/json/transferLocalWithoutFullName.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200
    And match $.Status.StatusCode != "M0000"


  Scenario: Transferencia a otro banco sin numero de identificacion en T24
    * def jsonRequest = read('classpath:APImethods/json/transferLocalWithoutPartyId.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200
    And match $.Status.StatusCode != "M0000"