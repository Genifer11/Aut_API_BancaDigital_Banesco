function fn() {
    karate.configure('ssl', true);

    let baseUrl = karate.properties['baseUrl'] || 'https://test.api.ob.banesco.com.pa/transfer/v3/transfers/'

    return {
           /*api: {
                baseUrl: baseUrl
            },
            path: {
                auth: '/qa/auth',
                //transferencias: ''
                } */
        };
    }