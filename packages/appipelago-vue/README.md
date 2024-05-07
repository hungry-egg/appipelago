# Vue 3 bindings for Appipelago Elixir library

## Pre-installation

If you wish to write single-file Vue components, you'll need to work with the Vue compiler somehow - this library does not cover that.

However, with the standard Phoenix ESBuild setup, it's easily done by:

1. Following [the instructions in the Phoenix docs](https://hexdocs.pm/phoenix/asset_management.html#esbuild-plugins) for using esbuild plugins
2. Adding a Vue ESBuild plugin such as [esbuild-plugin-vue3](https://www.npmjs.com/package/esbuild-plugin-vue3)
3. Adding `vue` as a dependency to your assets `npm install vue --prefix assets`

If you are only **using** Vue components as opposed to writing your own, you should be able to skip this step.

## Installation

- Follow the instructions from [the Appipelago library](https://github.com/hungry-egg/appipelago) to render js apps with Phoenix Liveview.

- Add the npm dependency `appipelago-vue` in the `assets` folder, e.g.

```
npm install --save appipelago-vue --prefix assets
```

## Usage

If we have a Vue `Counter` component that we would normally use in Vue like so

```vue
<Counter
  :counter="4"
  @inc="(amount) => console.log(`Increment by ${amount}`)"
/>
```

then we can render it from a LiveView with

```elixir
  def render(assigns) do
    ~H"""
      <.js_app
        id="my-counter"
        component="Counter"
        props={%{counter: @counter}}
        callbacks={%{inc: "increment"}}
      />
    """
  end

  def handle_event("increment", %{amount: amount}, socket) do
    IO.puts("Increment by #{amount}")
    {:noreply, socket}
  end
```

To do the above you need configure the hook in your `app.js` like so:

```diff
// ...
import { createJsApps } from "appipelago";
+import createVueApp from "appipelago-vue";
+import Counter from "path/to/vue/counter/component.vue";
// ...

let liveSocket = new LiveSocket("/live", Socket, {
  // ...
  hooks: {
    // ...
    appipelago: createJsApps({
      // ...
+      Counter: createVueApp(Counter, {
+        // not needed if you don't need to map callback params
+        callbackParams: {
+          inc: (amount) => ({ amount }),
+        },
+      }),
    }),
  },
});

// ...
```

If you don't map `callbackParams` then `handle_event` will be called with an empty map `%{}`.
In that case you can omit the options arg to createVueApp in `app.js`:

```js
Counter: createVueApp(Counter);
```