local orgmode_status_ok, orgmode = pcall(require, "orgmode")
if not orgmode_status_ok then
  print("no orgmode")
  return
end

local bullets_status_ok, bullets = pcall(require, "org-bullets")
if not bullets_status_ok then
  print("no bullets")
end

local headlines_status_ok, headlines = pcall(require, "headlines")
if not headlines_status_ok then
  print("no headlines")
end

orgmode.setup()
headlines.setup({
  markdown = {
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
  norg = {
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
  org = {
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
  rmd = {
    fat_headline_upper_string = "▄",
    fat_headline_lower_string = "▀",
  },
})
bullets.setup({})
