defmodule ExreportsTest do
  use ExUnit.Case

  describe "build/1" do
    test "should build the reports" do
      file_name = "report_test.csv"

      response = Exreports.build(file_name)

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "should build the reports when a file list is provided" do
      file_names = ["report_test.csv", "report_test.csv"]

      response = Exreports.build_from_many(file_names)

      expected_response =
        {:ok,
         %{
           "foods" => %{
             "açaí" => 2,
             "churrasco" => 4,
             "esfirra" => 6,
             "hambúrguer" => 4,
             "pastel" => 0,
             "pizza" => 4,
             "prato_feito" => 0,
             "sushi" => 0
           },
           "users" => %{
             "1" => 96,
             "10" => 72,
             "11" => 0,
             "12" => 0,
             "13" => 0,
             "14" => 0,
             "15" => 0,
             "16" => 0,
             "17" => 0,
             "18" => 0,
             "19" => 0,
             "2" => 90,
             "20" => 0,
             "21" => 0,
             "22" => 0,
             "23" => 0,
             "24" => 0,
             "25" => 0,
             "26" => 0,
             "27" => 0,
             "28" => 0,
             "29" => 0,
             "3" => 62,
             "30" => 0,
             "4" => 84,
             "5" => 98,
             "6" => 36,
             "7" => 54,
             "8" => 50,
             "9" => 48
           }
         }}

      assert response == expected_response
    end

    test "should return an error if a file list is not provided" do
      response = Exreports.build_from_many("banana")

      expected_response = {:error, "Please provide a list of strings!"}

      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "should return the user who spent the most if the option is 'users'" do
      file_name = "report_test.csv"

      response =
        file_name
        |> Exreports.build()
        |> Exreports.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "should return the most consumed food if the option is 'foods'" do
      file_name = "report_test.csv"

      response =
        file_name
        |> Exreports.build()
        |> Exreports.fetch_higher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "should return an error if is an invalid option" do
      file_name = "report_test.csv"

      response =
        file_name
        |> Exreports.build()
        |> Exreports.fetch_higher_cost("banana")

      expected_response = {:error, "Invalid option!"}

      assert response == expected_response
    end
  end
end
