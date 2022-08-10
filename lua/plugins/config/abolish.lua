local wk_status_ok, wk = pcall(require, "which-key")
if not wk_status_ok then return end

wk.register({
  c = {
    r = {
      name = 'Coerce Case',
      c = { "camelCase" },
      m = { "MixedCase" },
      ['_'] = { "snake_case" },
      s = { "snake_case" },
      u = { "SNAKE_UPPERCASE" },
      U = { "SNAKE_UPPERCASE" },
      ['-'] = { "dash-case" },
      k = { "kebab-case" },
      ['.'] = { "dot.case" },
      [' '] = { "space case" },
      t = { "Title Case" },
    },
  },
})
