import React from "react";
import {
    render,
} from "react-dom";
import {
    Provider,
} from "react-redux";
import {
    PersistGate,
} from "redux-persist/integration/react";
import {
    store,
    persistor,
} from "./store";

import { Root } from "./pages";



const App = ({
    store,
    persistor,
}) => (
        <Provider
            store={store}
        >
            <PersistGate
                loading={null}
                persistor={persistor}
            >
                <Root />
            </PersistGate>
        </Provider>
    );



render(
    <App
        store={store}
        persistor={persistor}
    />,
    document.getElementById("app")
);
