#####################################################################
#                            Build Stage                            #
#####################################################################
FROM hugomods/hugo:exts as builder
# Build site
COPY . /src
# Replace below build command at will.
RUN hugo --minify --enableGitInfo
# Set the fallback 404 page if defaultContentLanguageInSubdir is enabled,
# please replace the `en` with your default language code.
# RUN cp ./public/en/404.html ./public/404.html

#####################################################################
#                            Final Stage                            #
#####################################################################
FROM hugomods/hugo:nginx
# Copy the generated files to keep the image as small as possible.
COPY --from=builder /src/public /site
