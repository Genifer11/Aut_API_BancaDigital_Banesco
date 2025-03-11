Feature: Transferir - Internacional

  Background:
    * url 'https://test.api.ob.banesco.com.pa/transfer/v3/transfers/accounts/intl'
    * def AccesToken = Java.type('utils.AccesToken')
    * def accessToken = AccesToken.getAccessToken()
    * print 'Access Token:', accessToken

  Scenario: Transferencia internacional exitosa
    * def jsonRequest = read('classpath:APImethods/json/transferInternationalSuccess.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200

  Scenario: Transferencia internacional exitosa con todos los datos de respuesta
    * def jsonRequest = read('classpath:APImethods/json/transferInternationalSuccess.json')
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


  Scenario: Transf. internacional erronea sin tipo y subtipo de transaferencia
    * def jsonRequest = read('classpath:APImethods/json/transferInterWithoutTypeAndSubType.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 400
    And match $.Status.statusCode == "M0006"
    And match $.Status.statusDesc == "FALLO EN LA OPERACION"

  Scenario: Transf. internacional erronea sin cuenta de origen
    * def jsonRequest = read('classpath:APImethods/json/transferInterWithOutOriginAccount.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 400
    And match $.Status.statusCode == "M0006"
    And match $.Status.statusDesc == "FALLO EN LA OPERACION"
    And match $.Status.AdditionalStatus.statusDesc == "'AcctId'"


  Scenario: Transf. internacional erronea sin descripción
    * def jsonRequest = read('classpath:APImethods/json/transferInterWithOutwithOutDescription.json')
    And header Authorization = 'Bearer ' + accessToken
    And header RequestId = '202207280085'
    And header ClientDt = '2022-07-28T18:15:37'
    And header UserId = 'USRBOLINPUT'
    And header ChannelId = 'WebBanking'
    Given request jsonRequest
    When method POST
    Then status 200




