import 'babel-core/polyfill'
import React from 'react'
import { Provider } from 'react-redux'
import { ReduxRouter } from 'redux-router'

import configureStore from './store/configureStore'
import App from './containers/App'
import { receivedMessage } from './actions/messages'
import { fetchChannelsIfNeeded } from './actions/channels'
import routes from './routes'

import './../css/main'

const store = configureStore()

store.dispatch(fetchChannelsIfNeeded())

React.render(
  <Provider store={store}>
    {() =>
      <ReduxRouter>
        { routes }
      </ReduxRouter>
    }
  </Provider>,
  document.getElementById('client_root')
)