function updateThemeColor(brightness) {
    // Update the color of the theme,
    // indicated in <meta name="theme-color">.
    const darkColor = "#5F7C89";
    const lightColor = "#2294F0";

    // Remove all existing meta[name=theme-color] elements.
    document.querySelectorAll("meta[name=theme-color]").forEach(e => e.remove());

    // Create a new meta[name=theme-color] element.
    if (brightness === "dark") {
        _addMetaThemeColor(darkColor);
    } else if (brightness === "light") {
        _addMetaThemeColor(lightColor);
    } else {
        // Create a default meta[name=theme-color] element, with media query.
        _addMetaThemeColor(darkColor, "(prefers-color-scheme: dark)");
        _addMetaThemeColor(lightColor, "(prefers-color-scheme: light)");
    }
}

function _addMetaThemeColor(color, media) {
    const meta = document.createElement("meta");
    meta.name = "theme-color";
    meta.content = color;
    if (media) {
        meta.media = media;
    }
    document.head.appendChild(meta);
}