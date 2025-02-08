# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the project files and restore dependencies
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Use a smaller runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy published app from build stage
COPY --from=build /app/out .

# Expose the port your app runs on (match launch URL, e.g., 5152)
EXPOSE 5152

# Start the application
ENTRYPOINT ["dotnet", "MyAspNetApp.dll"]
