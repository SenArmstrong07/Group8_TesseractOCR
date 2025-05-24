FROM php:8.1-cli
# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        git \
        unzip \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-deu \
        tesseract-ocr-jpn \
        tesseract-ocr-fil \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Create uploads directory & make it writable
RUN mkdir -p uploads && chmod -R 777 uploads



# Start PHP built-in server (for development)
CMD ["php", "-S", "0.0.0.0:8080", "index.php"]

#TEST RUN
#docker run -it --rm -p 5000:8080 senarmstrong07/tesseract_ocr_g8
#To run the program: http://localhost:5000