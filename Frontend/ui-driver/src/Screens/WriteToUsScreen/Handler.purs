{-
 
  Copyright 2022-23, Juspay India Pvt Ltd
 
  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License
 
  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program
 
  is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 
  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details. You should have received a copy of
 
  the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
-}

module Screens.WriteToUsScreen.Handler where

import Engineering.Helpers.BackTrack (getState)
import Prelude (bind, pure, ($), (<$>))
import Screens.WriteToUsScreen.Controller (ScreenOutput(..))
import Control.Monad.Except.Trans (lift)
import Control.Transformers.Back.Trans (BackT(..), FailBack(..)) as App
import PrestoDOM.Core.Types.Language.Flow (runLoggableScreen)
import Screens.WriteToUsScreen.View as WriteToUsScreen
import Types.App (GlobalState(..), FlowBT, WRITE_TO_US_SCREEN_OUTPUT(..))

writeToUsScreen :: FlowBT String WRITE_TO_US_SCREEN_OUTPUT
writeToUsScreen = do
  (GlobalState state) <- getState
  action <- lift $ lift $ runLoggableScreen $ WriteToUsScreen.screen state.writeToUsScreen
  case action of
    GoBack -> App.BackT $ pure App.GoBack
    GoToHomeScreen -> App.BackT $ App.BackPoint <$> (pure $ GO_TO_HOME_SCREEN_FLOW)