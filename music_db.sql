-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 25, 2022 at 12:54 PM
-- Server version: 5.7.33
-- PHP Version: 8.0.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `music_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `image_url`) VALUES
(1, 'Illenium', 'https://i1.sndcdn.com/artworks-000275484077-uteehc-t500x500.jpg'),
(2, 'iMeiden', 'https://f4.bcbits.com/img/a1290321873_10.jpg'),
(3, 'San holo', 'https://i.pinimg.com/originals/29/eb/41/29eb41989cf2a26868eebd833ffa9058.jpg'),
(4, 'Hurshel', 'https://i1.sndcdn.com/artworks-lZAhqpNRj0128NLU-UwCbWQ-t500x500.jpg'),
(5, 'OHEY', 'https://i1.sndcdn.com/avatars-zqZsvPzzrSnAwHrZ-ZKZBbQ-t500x500.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_06_20_111521_create_artists_table', 1),
(6, '2022_06_20_111643_create_songs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `id` int(10) UNSIGNED NOT NULL,
  `artist_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `songs_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `artist_id`, `title`, `image_url`, `songs_url`) VALUES
(1, 1, 'Needed You', 'http://i3.ytimg.com/vi/96lCUfORlOo/maxresdefault.jpg', 'https://archive.org/download/llenium/Illenium%20-%20Needed%20You.mp3'),
(2, 1, 'Afterlife', 'http://i3.ytimg.com/vi/f4kqIruQcvQ/maxresdefault.jpg', 'https://archive.org/download/llenium/llenium%20-%20Afterlife.mp3'),
(3, 1, 'Leaving', 'http://i3.ytimg.com/vi/g80hMksipbI/maxresdefault.jpg', 'https://archive.org/download/llenium/Illenium%20-%20Leaving.mp3'),
(4, 1, 'Sleepwalker', 'http://i3.ytimg.com/vi/BfY7TfeGqV0/maxresdefault.jpg', 'https://archive.org/download/llenium/Illenium%20-%20Sleepwalker.mp3'),
(5, 1, 'Reverie', 'http://i3.ytimg.com/vi/tjg3-Wla3PU/maxresdefault.jpg', 'https://archive.org/download/llenium/Illenium%20-%20Reverie.mp3'),
(6, 2, 'Crossing', 'http://i3.ytimg.com/vi/my-MCqALHvE/maxresdefault.jpg', 'https://archive.org/download/imeiden/iMeiden%20-%20Crossing.mp3'),
(7, 2, 'Pursue', 'http://i3.ytimg.com/vi/Ct1fg8KZsLQ/maxresdefault.jpg', 'https://archive.org/download/imeiden/iMeiden%20-%20Pursue.mp3'),
(8, 2, 'Heartseeker', 'http://i3.ytimg.com/vi/Jbb7eIdAnUs/maxresdefault.jpg', 'https://archive.org/download/imeiden/iMeiden%20-%20Heartseeker.mp3'),
(9, 2, 'Shigre', 'http://i3.ytimg.com/vi/5g1tfQVr0z0/maxresdefault.jpg', 'https://archive.org/download/imeiden/iMeiden%20-%20Shigre.mp3'),
(10, 2, 'One', 'http://i3.ytimg.com/vi/sgxKrBvfbTU/maxresdefault.jpg', 'https://archive.org/download/imeiden/iMeiden%20-%20One.mp3'),
(11, 3, 'Light', 'http://i3.ytimg.com/vi/HBjCh2sMACQ/maxresdefault.jpg', 'https://archive.org/download/san-holo/y2meta.com%20-%20San%20Holo%20-%20Light%20%28256%20kbps%29.mp3'),
(12, 3, 'Show me', 'http://i3.ytimg.com/vi/7j-mAAaNzkw/maxresdefault.jpg', 'https://archive.org/download/san-holo/y2meta.com%20-%20San%20Holo%20-%20show%20me%20%28256%20kbps%29.mp3'),
(13, 3, 'Surface', 'http://i3.ytimg.com/vi/Ap4aHK6Civw/maxresdefault.jpg', 'https://archive.org/download/san-holo/y2meta.com%20-%20San%20Holo%20-%20Surface%20%28feat.%20Caspian%29%20%28128%20kbps%29.mp3'),
(14, 3, 'Still See Your Face', 'http://i3.ytimg.com/vi/kjeVSK0k8g4/maxresdefault.jpg', 'https://archive.org/download/san-holo/y2meta.com%20-%20San%20Holo%20-%20I%20Still%20See%20Your%20Face%20%28128%20kbps%29.mp3'),
(15, 3, 'Brighter Days', 'http://i3.ytimg.com/vi/mAM_1zDyOts/maxresdefault.jpg', 'https://archive.org/download/san-holo/y2meta.com%20-%20San%20Holo%20-%20brighter%20days%20%28feat.%20Bipolar%20Sunshine%29%20%28128%20kbps%29.mp3'),
(16, 4, 'Home', 'http://i3.ytimg.com/vi/yutBqNje548/maxresdefault.jpg', 'https://archive.org/download/hurshel/Hurshel%20-%20Home.mp3'),
(17, 4, 'Searching For You', 'http://i3.ytimg.com/vi/7bL4qQgvThQ/maxresdefault.jpg', 'https://archive.org/download/hurshel/Hurshel%20-%20Searching%20For%20You.mp3'),
(18, 4, 'Care', 'http://i3.ytimg.com/vi/fsHB6xkLjN8/maxresdefault.jpg', 'https://archive.org/download/hurshel/Hurshel%20-%20Care.mp3'),
(19, 4, 'Take You Anywhere', 'http://i3.ytimg.com/vi/yzLw1c93aZA/maxresdefault.jpg', 'https://archive.org/download/hurshel/Hurshel%20-%20Take%20You%20Anywhere.mp3'),
(20, 4, 'Desire', 'http://i3.ytimg.com/vi/7zEo92NgzBY/maxresdefault.jpg', 'https://archive.org/download/hurshel/Hurshel%20-%20Desire.mp3'),
(21, 5, 'Call My Name', 'http://i3.ytimg.com/vi/YVovO1ZgLLY/maxresdefault.jpg', 'https://archive.org/download/oheys/OHEY%20-%20Call%20My%20Name.mp3'),
(22, 5, 'Be Alone', 'http://i3.ytimg.com/vi/BuFOjOS8tks/maxresdefault.jpg', 'https://archive.org/download/oheys/OHEY%20-%20Be%20Alone.mp3'),
(23, 5, 'With Me', 'http://i3.ytimg.com/vi/NAi6SjO15_0/maxresdefault.jpg', 'https://archive.org/download/oheys/OHEY%20-%20With%20Me.mp3'),
(24, 5, 'World Apart', 'http://i3.ytimg.com/vi/dDUPchpujDc/maxresdefault.jpg', 'https://archive.org/download/oheys/OHEY%20-%20World%20Apart.mp3'),
(25, 5, 'Forgiveness', 'http://i3.ytimg.com/vi/Kshz5nliCco/maxresdefault.jpg', 'https://archive.org/download/oheys/OHEY%20-%20Forgiveness.mp3');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Alf', 'relafz', 'open', '2022-07-06 05:17:06', '2022-07-06 05:17:06'),
(2, 'izi', 'slot', '$2y$10$A1XV9Q3k9Hiw72Bm2C.OtOs91Qe0aqeaS5xSuxh1eTvpH5QFEkum2', '2022-07-06 23:53:06', '2022-07-06 23:53:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `songs_artist_id_foreign` (`artist_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `songs`
--
ALTER TABLE `songs`
  ADD CONSTRAINT `songs_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
